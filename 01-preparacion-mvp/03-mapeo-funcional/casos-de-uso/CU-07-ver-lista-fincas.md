# CU-07 — Ver lista de fincas en dashboard

| Campo | Valor |
|---|---|
| **ID** | CU-07 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego entra al dashboard tras login o pull-to-refresh manual. |
| **Endpoints invocados** | `farmsListOwn` (`GET /v1/farms`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 5 (Dashboard con fincas). Ruta: `Routes.dashboard`. |
| **RFs cubiertos** | RF-01, RF-07. |

## Preconditions
- Diego está autenticado.
- Diego tiene ≥1 finca creada (CU-06).
- Hay conexión a internet **o** las fincas ya están en WatermelonDB local.

## Escenario principal (Main Success Scenario)
1. Diego completa login (CU-02) → app navega a `Routes.dashboard`.
2. Mobile dispara `GET /v1/farms` vía `FarmsNotifier.build()`.
3. Backend responde `{ success: true, data: [Farm, Farm, ...] }`.
4. UI rinde **Pantalla 5 — Dashboard con fincas**: lista vertical de tarjetas (`FarmCard`) con:
   - Nombre.
   - Municipio/dirección.
   - Cultivo principal.
   - Badge de certificaciones (vacío en MVP).
5. En la parte superior: `OfflineIndicator` (banda naranja si no hay red) y `SyncStatusBadge` (estado de sync).
6. En la parte inferior: botón flotante "+" para registrar finca; entrada "Alertas" en el AppBar.

## Flujos alternos
- **A. Sin fincas** → la app rinde **Pantalla 4 — Dashboard vacío** (ilustración + "Aún no has registrado una finca" + botón "Registrar finca").
- **B. Sin conexión** → la app rinde las fincas desde WatermelonDB local + muestra `OfflineIndicator`. Las fincas con `_status='created'` o `'updated'` aparecen igual.
- **C. Error 500 del servidor** → snackbar "Error cargando fincas, intenta de nuevo" + se rinden datos locales si existen.
- **D. Pull-to-refresh** → re-dispara `GET /v1/farms` y refresca la lista.

## Postcondition
- UI rinde la lista correcta y vigente.
- WatermelonDB local actualizado con los últimos datos del servidor (si hubo conexión).

## Acceptance criteria (Given/When/Then)
- **Given** Diego tiene 3 fincas, **When** abre el dashboard, **Then** ve las 3 tarjetas ordenadas (por `created_at` desc o nombre — confirmar comportamiento).
- **Given** Diego tiene 0 fincas, **When** entra al dashboard, **Then** ve la Pantalla 4 (estado vacío).
- **Given** está offline, **When** abre el dashboard, **Then** ve las fincas locales + banda `OfflineIndicator`.
- **Given** toca una tarjeta de finca, **When** la app responde, **Then** navega a `Routes.farmDetail(<id>)` (Pantalla 7).

## Estado de prueba
- **Estado:** 🟡 pendiente
- **Fecha de prueba:**
- **Versión APK probada:**
- **Notas de Diego:**
  > <espacio para anotar lo observado>

## Bugs históricos relevantes
- Ninguno documentado para esta pantalla en CHANGELOG.
