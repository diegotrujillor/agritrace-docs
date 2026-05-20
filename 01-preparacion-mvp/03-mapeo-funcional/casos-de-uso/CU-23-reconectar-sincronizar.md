# CU-23 — Reconectar y sincronizar (push + pull)

| Campo | Valor |
|---|---|
| **ID** | CU-23 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego desactiva modo avión / recupera red; o toca el `SyncStatusBadge` manualmente. |
| **Endpoints invocados** | `syncPush` (`POST /v1/sync`), `syncGetChanges` (`GET /v1/sync/changes?since=<ISO>`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Cualquier pantalla con `SyncStatusBadge`. Generalmente Dashboard o Alertas. |
| **RFs cubiertos** | RF-06 (sync automática bidireccional), RF-11 (indicador de estado). |

## Preconditions
- Diego completó CU-22 (tiene N cambios pendientes en WatermelonDB).
- Diego está autenticado (refresh válido).
- Backend prod responde 200 a `/v1/health`.
- Hay conexión a internet.

## Escenario principal (Main Success Scenario)
1. Diego apaga el modo avión / recupera red.
2. La app detecta conectividad → `OfflineIndicator` desaparece; `SyncStatusBadge` pasa a "Sincronizando…".
3. **Push:** mobile arma payload con los cambios `_status IN ('created','updated')`, en batches de ≤500 cambios, agrupados por entidad (farm/plot/activity/alert). Dispara `POST /v1/sync`.
4. Backend procesa cada cambio en un SAVEPOINT (un cambio inválido **no aborta** el batch — se marca como conflicto). Aplica LWW sobre `updated_at`. Responde `{ synced: N, conflicts: M, timestamp: <ISO> }`.
5. Mobile actualiza los registros locales: `_status='synced'`, `synced_at=<timestamp>`.
6. **Pull:** mobile dispara `GET /v1/sync/changes?since=<lastSyncTimestamp>` → backend retorna `{ changes: [...], timestamp: <ISO> }` con todo lo que cambió en el servidor.
7. Mobile aplica los cambios en WatermelonDB (resolviendo conflictos por LWW — ver CU-24).
8. `SyncStatusBadge` pasa a "Sincronizado" (verde). Snackbar opcional: "Sincronizado: N cambios subidos, M descargados".

## Flujos alternos
- **A. Token expirado al inicio del sync** → `_AuthInterceptor` intenta refresh; si falla, fuerza re-login y aborta el sync (los cambios siguen pendientes).
- **B. Conflictos LWW (M > 0)** → ver CU-24. La UI debe ofrecer revisar los items conflictivos (en MVP se aplica LWW silenciosamente; UX mejorable).
- **C. Batch >500 cambios** → mobile divide en múltiples requests.
- **D. Error 500 del servidor** → snackbar "Error sincronizando, intenta más tarde"; los cambios siguen `_status='created'/'updated'` para reintentar.
- **E. Sync manual** (Diego toca `SyncStatusBadge`) → mismo flujo aún si la red ya estaba activa.

## Postcondition
- Cambios locales con `_status='synced'`, `synced_at` poblado.
- Backend con filas alineadas con el cliente.
- WatermelonDB local refleja cambios del servidor (creados por otro dispositivo o anterior session).
- Verificable: contadores en backend `SELECT COUNT(*) FROM farms WHERE producer_id='<id>';` igual a contador local.

## Acceptance criteria (Given/When/Then)
- **Given** Diego tiene 5 cambios pendientes y recupera red, **When** la app sincroniza, **Then** los 5 quedan `_status='synced'` y existen en backend en ≤10 s (red 4G normal).
- **Given** un cambio falla validación, **When** el batch se procesa, **Then** ese cambio queda como conflicto pero los demás se sincronizan (SAVEPOINT por cambio — ver backend CHANGELOG `Sprint 4 — sync hardening`).
- **Given** el servidor tiene cambios nuevos (creados por sync de otro dispositivo), **When** Diego sincroniza, **Then** esos cambios aparecen en WatermelonDB local.

## Estado de prueba
- **Estado:** 🟡 pendiente
- **Fecha de prueba:**
- **Versión APK probada:**
- **Notas de Diego:**
  > <espacio para anotar lo observado>

## Bugs históricos relevantes
- **Sprint 4 backend** — `sync.service` hardening: un cambio inválido ya no aborta el batch (SAVEPOINT por cambio). Confirmar comportamiento. Ver backend CHANGELOG entrada `[0.1.9] - Sprint 4: alertas + notificaciones + sync hardening`.
