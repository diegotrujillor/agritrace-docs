# CU-08 — Ver detalle de finca + editar

| Campo | Valor |
|---|---|
| **ID** | CU-08 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego toca una tarjeta de finca en la Pantalla 5 (Dashboard). |
| **Endpoints invocados** | `farmsGetById` (`GET /v1/farms/{id}`), `farmsUpdate` (`PUT /v1/farms/{id}`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 5 → Pantalla 7 (Vista finca) → form de edición (modal o reuso de Pantalla 6). Ruta: `Routes.farmDetail(<id>)`. |
| **RFs cubiertos** | RF-01, RF-07. |

## Preconditions
- Diego está autenticado.
- Existe ≥1 finca propia.
- Hay conexión a internet (para `PUT`; lectura puede ser offline desde WatermelonDB).

## Escenario principal (Main Success Scenario)
1. Diego está en **Pantalla 5 — Dashboard**.
2. Toca una tarjeta de finca → navega a `Routes.farmDetail(<id>)` (**Pantalla 7 — Vista finca**).
3. Mobile dispara `GET /v1/farms/{id}` y rinde:
   - Nombre.
   - Cultivo principal.
   - Área en hectáreas (si existe).
   - Coordenadas + mapa estático (si existen).
   - Dirección.
   - Lista de lotes (vacía o con tarjetas).
   - Botón **"Registrar lote"**.
4. Diego toca el botón de editar (icono lápiz en AppBar) → se abre el form con los datos actuales pre-cargados.
5. Cambia, por ejemplo, el nombre o el cultivo.
6. Toca **"Guardar"** → mobile dispara `PUT /v1/farms/{id}` con `UpdateFarmInput` (al menos 1 campo).
7. Backend valida (Zod), actualiza `farms` con `updated_at = NOW()`, responde 200 con el Farm actualizado.
8. UI vuelve a Pantalla 7 con los nuevos valores; snackbar "Finca actualizada".

## Flujos alternos
- **A. Finca de otro productor** (URL manipulada) → backend responde `403 ForbiddenError` → snackbar "Sin permiso".
- **B. Finca no existe** → `404 NotFoundError` → la app navega de regreso al Dashboard con snackbar "Finca no encontrada".
- **C. Body de edición vacío** → Zod (`minProperties: 1`) falla → 400 → snackbar "Cambia al menos un campo".
- **D. Sin conexión durante editar** → cambios se guardan en WatermelonDB local con `_status='updated'`, se sincronizan después (CU-23).

## Postcondition
- Fila `farms` con `updated_at` actualizado y los campos cambiados.
- UI muestra los valores nuevos.
- Verificable: `SELECT name, crop_type, updated_at FROM farms WHERE id = '<id>';`.

## Acceptance criteria (Given/When/Then)
- **Given** Diego está en Pantalla 7, **When** edita el nombre y guarda, **Then** la fila en `farms` cambia y la UI muestra el nuevo nombre en ≤2 s.
- **Given** Diego intenta acceder a una finca ajena, **When** mobile llama `GET /v1/farms/{id}`, **Then** recibe 403 (no 404) — confirma que el ownership check funciona.
- **Given** no hay conexión, **When** Diego edita, **Then** el cambio queda en WatermelonDB local con `_status='updated'` y se sincroniza al reconectar.

## Estado de prueba
- **Estado:** ⚠️ pasa con notas — ver finca ✅, editar persiste pero UX stale
- **Fecha de prueba:** 2026-05-20
- **Versión APK probada:** 1.3.5
- **Entorno:** emulador AVD + backend v0.4.1.
- **Notas de Diego (auto):**
  > **Ver detalle ✅:** tap card de finca → navega al detail screen con nombre, cultivo, área. La sección Lotes se renderiza correctamente tras el fix v1.3.5 de URL.
  > **Editar ⚠️:** tap "Editar finca" → form pre-fillado (nombre + cultivo + área + dirección). Modifiqué área de 7.0 → 8.5 + tap "Guardar cambios" → PUT /v1/farms/:id 200 en backend (verificado en DB: area_hectares=8.50). Sin embargo, la pantalla de detalle siguió mostrando "Área: 7.0 ha" hasta navegar atrás + reabrir.
  > **Bug UX:** el `_refresh()` de `farmsProvider` actualiza la lista pero el detail screen lee un `farmProvider(id)` separado que no se invalidó. Tras navegar atrás → dashboard muestra el valor actualizado (8.5 ha) y al re-tapear el card el detail también. Workaround: pull-to-refresh o re-navegar.
  > **Backend OK.** Fix sugerido en mobile: `farmsProvider.updateFarm` debe invalidar `farmProvider(id)` también, o el detail watch debe combinarse con la lista. P3 — no bloquea Sprint 5 (datos correctos, sólo refresh tardío).

## Bugs históricos relevantes
- Ninguno documentado en CHANGELOG.
