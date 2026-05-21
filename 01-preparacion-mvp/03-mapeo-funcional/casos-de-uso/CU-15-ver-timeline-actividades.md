# CU-15 — Ver timeline ordenado por fecha

| Campo | Valor |
|---|---|
| **ID** | CU-15 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego abre la Pantalla 9 (Vista lote) o toca "Ver todas las actividades" desde un resumen. |
| **Endpoints invocados** | `activitiesListByPlot` (`GET /v1/activities/plots/{plotId}/activities`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 9 (Vista del Lote, sección timeline). Ruta: `Routes.activityTimeline(<plotId>)` o sección embebida en `Routes.plotDetail(<id>)`. |
| **RFs cubiertos** | RF-04 (historial cronológico). |

## Preconditions
- Diego está autenticado.
- Existe el lote con ≥1 actividad.

## Escenario principal (Main Success Scenario)
1. Diego está en **Pantalla 9** y hace scroll a la sección timeline.
2. Mobile ya cargó `GET /v1/activities/plots/{plotId}/activities` (vía CU-11).
3. UI rinde una lista vertical: cada item tiene icono por tipo (sowing/fert/irr/pest/harvest/other), fecha formateada localmente (es-CO), descripción truncada (2 líneas), miniatura de foto si existe.
4. La lista está ordenada **por `occurred_at` DESC** (más reciente arriba). El ordenamiento se calcula una vez por emisión (perf fix v1.3.x).
5. Diego puede:
   - Hacer scroll vertical.
   - Tocar un item → navega a vista detalle (CU-16/17 base).
   - Pull-to-refresh para re-pedir el GET.

## Flujos alternos
- **A. Sin actividades** → `EmptyState`: "Aún no has registrado actividades en este lote".
- **B. Sin conexión** → rinde desde WatermelonDB local. Actividades `_status='created'` muestran un icono "pendiente de sync" sutil.
- **C. Timeline largo (>50 items)** → colapsar items antiguos con un "Ver más antiguas" (regla UX §4).

## Postcondition
- UI vigente con orden correcto. No cambia datos.

## Acceptance criteria (Given/When/Then)
- **Given** Diego tiene 3 actividades fechadas 2026-04-01, 2026-05-10 y 2026-05-19, **When** abre Pantalla 9, **Then** el orden visible es 2026-05-19 (top) → 2026-05-10 → 2026-04-01 (bottom).
- **Given** la lista tiene >20 actividades, **When** Diego hace scroll, **Then** el scroll es fluido (sin reordenamiento por item).
- **Given** está offline, **When** abre la pantalla, **Then** ve actividades locales + indicador de offline.

## Estado de prueba
- **Estado:** ✅ pasa (v1.4.1) — retest E2E en emulador OK
- **Fecha de prueba:** 2026-05-20
- **Versión APK probada:** 1.4.1
- **Notas de Diego (auto):**
  > Pantalla `activity_timeline_screen.dart` existe, renderiza `ListView` con `itemBuilder`, perf fix pre-v1.3.3 ya en su lugar (orden por `occurred_at` DESC fuera del builder). `EmptyState` correcto. Botón "Registrar actividad" presente. Sin actividades reales aún por bug [[CU-14]]; en el árbol vacío se rinde el EmptyState correctamente (verificado al abrir lote nuevo).
  > **Retest emulador 2026-05-20 (v1.4.1):** ✅ — tras registrar "Siembra · 20/05/2026" ([[CU-14]]), el item aparece en el timeline con icono + fecha local. EmptyState correcto antes de registrar y después de eliminar ([[CU-17]]). Long-press abre el bottom sheet Editar/Eliminar.

## Bugs históricos relevantes
- **Pre v1.3.3** — orden O(n²) dentro de `itemBuilder` corregido. Confirmar fluidez del scroll. Ver CHANGELOG entrada `refactor de seams compartidos + fixes — perf (bug)`.
