# CU-09 — Eliminar finca (cascada visible: los lotes desaparecen)

| Campo | Valor |
|---|---|
| **ID** | CU-09 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego toca el botón **"Eliminar finca"** en el AppBar / menú de la Pantalla 7. |
| **Endpoints invocados** | `farmsDelete` (`DELETE /v1/farms/{id}`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 7 (Vista finca) → diálogo confirmación → Pantalla 5 (Dashboard). |
| **RFs cubiertos** | RF-01, RF-07. |

## Preconditions
- Diego está autenticado.
- Existe la finca con ≥1 lote y ≥1 actividad (para validar cascada).
- Hay conexión a internet.

## Escenario principal (Main Success Scenario)
1. Diego está en **Pantalla 7 — Vista finca**.
2. Toca el botón de eliminar (icono basurero en AppBar / menú).
3. Aparece diálogo: "¿Eliminar la finca '<nombre>'? Se eliminarán también los lotes y actividades asociados." + botones "Cancelar" / "Eliminar".
4. Diego toca **"Eliminar"**.
5. Mobile dispara `DELETE /v1/farms/{id}`.
6. Backend ejecuta soft-delete en cascada (ver [`refactor: seams compartidos backend`](../../../../agritrace-backend/CHANGELOG.md)): `farms.deleted_at`, todos los `plots` de la finca, todas las `activities` de esos lotes. Responde 200 `{ deleted: true }`.
7. Mobile vuelve a `Routes.dashboard` (Pantalla 5) — la finca ya no aparece en la lista. Lotes y actividades de esa finca tampoco son visibles en ninguna pantalla.

## Flujos alternos
- **A. Cancelar diálogo** → no se llama al endpoint.
- **B. Finca de otro productor** → `403 ForbiddenError`.
- **C. Finca ya eliminada** → `404 NotFoundError`.
- **D. Sin conexión** → la operación destructiva **no** se encola offline en MVP (decisión de seguridad). Snackbar "Sin conexión, intenta más tarde".

## Postcondition
- `farms.deleted_at IS NOT NULL` para la finca.
- `plots.deleted_at IS NOT NULL` para todos los lotes hijos.
- `activities.deleted_at IS NOT NULL` para todas las actividades de esos lotes.
- UI Dashboard sin la finca eliminada.
- Verificable: `SELECT COUNT(*) FROM plots WHERE farm_id = '<id>' AND deleted_at IS NULL;` → 0.

## Acceptance criteria (Given/When/Then)
- **Given** Diego tiene una finca con 2 lotes y 5 actividades, **When** confirma eliminarla, **Then** la finca + los 2 lotes + las 5 actividades quedan soft-deleted.
- **Given** la finca fue eliminada, **When** Diego abre Dashboard, **Then** la finca ya no aparece en la lista.
- **Given** Diego cancela el diálogo, **When** no toca confirmar, **Then** no hay request HTTP ni cambio en DB.

## Estado de prueba
- **Estado:** 🟡 pendiente
- **Fecha de prueba:**
- **Versión APK probada:**
- **Notas de Diego:**
  > <espacio para anotar lo observado>

## Bugs históricos relevantes
- Ninguno documentado en CHANGELOG.
