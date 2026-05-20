# CU-11 — Ver detalle de lote + timeline de actividades

| Campo | Valor |
|---|---|
| **ID** | CU-11 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego toca un lote en la lista de la Pantalla 7 (Vista finca). |
| **Endpoints invocados** | `plotsGetById` (`GET /v1/plots/{id}`), `activitiesListByPlot` (`GET /v1/activities/plots/{plotId}/activities`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 9 (Vista del Lote ⭐ — la más importante del MVP). Ruta: `Routes.plotDetail(<id>)`. |
| **RFs cubiertos** | RF-02, RF-03 (actividades), RF-04 (timeline). |

## Preconditions
- Diego está autenticado.
- Existe el lote con ≥0 actividades.
- Hay conexión a internet **o** datos en WatermelonDB local.

## Escenario principal (Main Success Scenario)
1. Diego está en **Pantalla 7 — Vista finca**.
2. Toca una tarjeta de lote → navega a `Routes.plotDetail(<id>)` (**Pantalla 9 — Vista del Lote**).
3. Mobile dispara `GET /v1/plots/{id}` + `GET /v1/activities/plots/{plotId}/activities` en paralelo.
4. UI rinde:
   - Info del lote (nombre, cultivo, variedad, área, status, fechas).
   - Timeline vertical de actividades, ordenado por `occurred_at` DESC (más reciente primero). Ver [perf fix en CHANGELOG](../../../../agritrace-mobile/CHANGELOG.md): el ordenamiento se hace una vez al cargar, no en el `itemBuilder`.
   - Cada item del timeline: icono por tipo (sowing/fertilization/irrigation/pest_control/harvest/other), fecha (formato local), descripción truncada, miniatura de foto si existe.
   - Botones inferiores: **"Registrar actividad"**, **"Exportar PDF de trazabilidad"**. (El botón "Generar QR" **NO** aparece — diferido a iteración futura.)
5. Diego puede hacer scroll, tocar una actividad para ver detalle, o tocar los botones de acción.

## Flujos alternos
- **A. Sin actividades** → timeline muestra estado vacío (`EmptyState` widget: "Aún no has registrado actividades en este lote").
- **B. Lote de otro productor** → `403 ForbiddenError` → snackbar + back.
- **C. Lote no existe** → `404 NotFoundError` → back a Pantalla 7.
- **D. Sin conexión** → rinde desde WatermelonDB local + `OfflineIndicator`.
- **E. Timeline largo (>50 actividades)** → la UI colapsa items antiguos / paginación (ver Reglas UX §4 de espec-pantallas).

## Postcondition
- UI vigente.
- No cambia datos (operación de lectura).

## Acceptance criteria (Given/When/Then)
- **Given** Diego tiene un lote con 5 actividades, **When** abre Pantalla 9, **Then** ve las 5 ordenadas por `occurred_at` DESC en ≤2 s.
- **Given** el lote no tiene actividades, **When** abre Pantalla 9, **Then** ve el estado vacío con botón "Registrar actividad".
- **Given** está offline, **When** abre el lote, **Then** ve actividades locales + banda `OfflineIndicator`.
- **Given** el lote tiene foto en la actividad, **When** Diego toca la miniatura, **Then** se abre la foto en grande.

## Estado de prueba
- **Estado:** 🟡 pendiente
- **Fecha de prueba:**
- **Versión APK probada:**
- **Notas de Diego:**
  > <espacio para anotar lo observado>

## Bugs históricos relevantes
- **Pre v1.3.3** — `activity_timeline_screen` ordenaba actividades dentro de `itemBuilder` (O(n²) en scroll). Confirmar que el scroll es fluido aun con >20 items. Ver CHANGELOG entrada `refactor de seams compartidos + fixes — perf (bug)`.
