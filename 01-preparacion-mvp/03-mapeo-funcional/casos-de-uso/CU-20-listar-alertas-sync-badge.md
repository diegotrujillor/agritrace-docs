# CU-20 — Listar alertas + sync status badge

| Campo | Valor |
|---|---|
| **ID** | CU-20 |
| **Actor primario** | Productor |
| **Prioridad MVP** | SHOULD |
| **Disparador** | Diego toca el ícono **"Alertas"** en el AppBar del Dashboard. |
| **Endpoints invocados** | `alertsList` (`GET /v1/alerts`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Dashboard → Alertas (lista). Ruta: `Routes.alerts`. |
| **RFs cubiertos** | RF-09, RF-10, RF-11 (indicador de sincronización). |

## Preconditions
- Diego está autenticado.
- Tiene ≥0 alertas (la lista puede estar vacía).

## Escenario principal (Main Success Scenario)
1. Diego está en Dashboard, toca **"Alertas"** → navega a `Routes.alerts`.
2. Mobile dispara `GET /v1/alerts` → backend retorna lista (`[Alert, Alert, ...]`).
3. UI rinde:
   - En el AppBar: `SyncStatusBadge` clickeable (estados: `synced` / `syncing` / `offline` / `conflicts`). Al tocar dispara sync manual (CU-23).
   - Lista de alertas ordenada por `created_at` DESC: cada item muestra icono por tipo (clima ☁️ / recordatorio 🔔), color por `severity`, título, fecha relativa, badge de `status` (pending/sent/dismissed).
4. Pull-to-refresh re-dispara el GET.

## Flujos alternos
- **A. Lista vacía** → `EmptyState`: "No tienes alertas".
- **B. Sin conexión** → rinde desde WatermelonDB local; `SyncStatusBadge` muestra "Offline" (naranja).
- **C. Token expirado** → `_AuthInterceptor` refresca o redirige a Login.
- **D. Toque en una alerta** → navega a detalle (`alertsGetById`) o expande inline para mostrar `body` completo.

## Postcondition
- UI rinde lista vigente.
- WatermelonDB local actualizado.
- No cambia datos (lectura).

## Acceptance criteria (Given/When/Then)
- **Given** Diego tiene 2 recordatorios + 1 weather alert, **When** abre Alertas, **Then** ve los 3 items con iconos/colores correctos en ≤2 s.
- **Given** lista vacía, **When** abre Alertas, **Then** ve el `EmptyState`.
- **Given** está offline, **When** abre Alertas, **Then** ve datos locales + `SyncStatusBadge` en "Offline".
- **Given** Diego toca `SyncStatusBadge`, **When** hay cambios pendientes, **Then** dispara sync (CU-23) y muestra "Sincronizando…".

## Estado de prueba
- **Estado:** 🟡 pendiente
- **Fecha de prueba:**
- **Versión APK probada:**
- **Notas de Diego:**
  > <espacio para anotar lo observado>

## Bugs históricos relevantes
- Ninguno documentado en CHANGELOG. (`SyncStatusBadge` agregado en Sprint 4 — ver mobile CHANGELOG entrada `[1.2.0] - Sprint 4`.)
