# CU-24 — Resolución de conflicto LWW (dos clientes editan misma fila offline)

| Campo | Valor |
|---|---|
| **ID** | CU-24 |
| **Actor primario** | Productor |
| **Prioridad MVP** | SHOULD |
| **Disparador** | Dos dispositivos (o el mismo dispositivo después de un re-install) editan la misma fila offline y sincronizan en momentos distintos. |
| **Endpoints invocados** | `syncPush` (`POST /v1/sync`) — la resolución es server-side. |
| **Pantallas** | Cualquier pantalla con datos visibles + `SyncStatusBadge`. |
| **RFs cubiertos** | RF-06 (sync), RNF-02 (offline-first). |

## Preconditions
- Diego está autenticado en el Pixel.
- Diego (o un colega/segundo dispositivo) tiene la misma cuenta en otro dispositivo (Pixel emulador o segundo APK), también autenticado. **Opcional para smoke-test** (ver nota abajo).
- Ambos dispositivos tienen una fila idéntica sincronizada previamente (ej. una actividad con `id=X`, `description='Original'`).

> **Nota práctica para Diego:** este CU **requiere un segundo dispositivo** (o curl manual al backend con el `accessToken`) para reproducir auténticamente. Si solo hay un Pixel disponible, se puede simular: editar offline en la app → modificar la misma fila directamente vía curl al backend → reconectar la app. Marcar el CU como ⚠️ si la prueba se hizo simulada y como ✅ si se usaron dos dispositivos reales.

## Escenario principal (Main Success Scenario)
1. Hora T0: ambos dispositivos tienen la actividad `X` sincronizada con `description='Original'`, `updated_at=T0`.
2. Hora T1 (offline en ambos): Dispositivo A edita `description='Versión A'` → `updated_at=T1`. Dispositivo B edita `description='Versión B'` → `updated_at=T2`, donde T2 > T1.
3. Hora T3 (Dispositivo A recupera red primero): A sincroniza. Backend acepta el cambio: `description='Versión A'`, `updated_at=T1`. `syncPush` retorna `{ synced: 1, conflicts: 0 }`.
4. Hora T4 (Dispositivo B recupera red): B sincroniza. Backend compara: `updated_at` de B (T2) > `updated_at` actual server (T1) → **gana B**. La fila pasa a `description='Versión B'`, `updated_at=T2`. `syncPush` retorna `{ synced: 1, conflicts: 0 }` (LWW resuelto silenciosamente).
5. Hora T5 (Dispositivo A vuelve a sincronizar — pull): recibe `description='Versión B'` desde `GET /v1/sync/changes`. WatermelonDB local de A se actualiza con la versión ganadora.

## Flujos alternos
- **A. Updated_at idéntico** (colisión exacta — improbable porque `updated_at` se genera client-side al editar) → el comportamiento depende del orden de llegada al servidor (último gana). UX: anotar si pasa, es bug de modelo.
- **B. Soft-delete contra update** (uno borra, otro edita) → el delete con `updated_at` mayor gana → la fila queda soft-deleted (la edición se pierde silenciosamente). MVP acepta esto; mejora futura: confirmación de usuario.
- **C. Conflicto en batch grande** → el SAVEPOINT por cambio aísla el conflicto del resto del batch. `conflicts` cuenta los que perdieron LWW.

## Postcondition
- Backend con la versión cuya `updated_at` es mayor.
- WatermelonDB local de **ambos** dispositivos converge a la versión ganadora tras el siguiente pull.
- Verificable: `SELECT id, description, updated_at FROM activities WHERE id = '<X>';` retorna la versión esperada.

## Acceptance criteria (Given/When/Then)
- **Given** dos dispositivos editan la misma fila offline con timestamps distintos, **When** ambos sincronizan en orden, **Then** la versión con `updated_at` mayor gana y los dos clientes convergen tras el siguiente pull.
- **Given** un cambio "pierde" el LWW, **When** el cliente revisa la fila, **Then** ve el contenido ganador (no su propia versión local).
- **Given** la app de Diego, **When** se ejecuta sync con conflicto, **Then** el `SyncStatusBadge` muestra "Sincronizado" (en MVP los conflicts no bloquean; documentar en notas si se desea ofrecer UX para revisar).

## Estado de prueba
- **Estado:** 🟡 pendiente
- **Fecha de prueba:**
- **Versión APK probada:**
- **Notas de Diego:**
  > <espacio para anotar lo observado> — **requiere segundo dispositivo o curl manual**. Si se prueba con curl, anotar el script usado.

## Bugs históricos relevantes
- **Sprint 4 backend** — la lógica LWW está documentada y testeada en `sync.service.ts`. Confirmar comportamiento en prueba real (no solo tests unitarios). Ver backend CHANGELOG entradas `Sprint 3` y `Sprint 4 — sync hardening`.
