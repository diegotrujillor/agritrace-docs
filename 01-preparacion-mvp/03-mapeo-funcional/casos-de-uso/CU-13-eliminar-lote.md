# CU-13 — Eliminar lote (cascada: las actividades desaparecen)

| Campo | Valor |
|---|---|
| **ID** | CU-13 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego toca el botón de eliminar lote en el AppBar de la Pantalla 9. |
| **Endpoints invocados** | `plotsDelete` (`DELETE /v1/plots/{id}`) — añadido en v0.2.x. Ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 9 (Vista lote) → diálogo → Pantalla 7 (Vista finca). |
| **RFs cubiertos** | RF-02, RF-04. |

## Preconditions
- Diego está autenticado.
- Existe el lote propio con ≥1 actividad.
- Hay conexión a internet.

## Escenario principal (Main Success Scenario)
1. Diego está en **Pantalla 9 — Vista lote**.
2. Toca eliminar (basurero).
3. Diálogo: "¿Eliminar el lote '<nombre>'? Se eliminarán también las actividades." + "Cancelar" / "Eliminar".
4. Toca **"Eliminar"** → `DELETE /v1/plots/{id}`.
5. Backend soft-deletea el lote + cascada en `activities`. Responde 200.
6. Mobile navega de regreso a `Routes.farmDetail(<farmId>)` (Pantalla 7). El lote ya no aparece en la lista.

## Flujos alternos
- **A. Cancelar diálogo** → no se llama endpoint.
- **B. Lote ajeno** → 403.
- **C. Lote inexistente** → 404.
- **D. Sin conexión** → snackbar "Sin conexión, intenta más tarde" (no se encola offline).

## Postcondition
- `plots.deleted_at IS NOT NULL`.
- `activities.deleted_at IS NOT NULL` para todas las actividades del lote.
- UI sin el lote eliminado.
- Verificable: `SELECT COUNT(*) FROM activities WHERE plot_id = '<id>' AND deleted_at IS NULL;` → 0. Ver [backend CHANGELOG entrada `feat(plots delete) + docs(OpenAPI 3.0)`](../../../../agritrace-backend/CHANGELOG.md).

## Acceptance criteria (Given/When/Then)
- **Given** Diego tiene un lote con 3 actividades, **When** confirma eliminar, **Then** el lote + las 3 actividades quedan soft-deleted.
- **Given** el lote fue eliminado, **When** Diego abre Pantalla 7, **Then** la finca no muestra ese lote.
- **Given** Diego cancela el diálogo, **When** no toca confirmar, **Then** no hay request HTTP ni cambio en DB.

## Estado de prueba
- **Estado:** ✅ pasa (v1.4.0)
- **Fecha de prueba:** 2026-05-20
- **Versión APK probada:** 1.4.0 (CI commit `d04824a`)
- **Notas de Diego (auto):**
  > Shipping: acción "Eliminar lote" en `PopupMenuButton` de `plot_detail_screen` + `AlertDialog` "¿Eliminar lote?" con copy de cascada ("las actividades asociadas también se eliminarán") + redirect a `farmDetail` tras confirmar. Commit `3e0ac0e` en main.
  > **Tests añadidos:** `test/widget/plot_detail_delete_test.dart` (confirm + cancel paths).
  > **Retest E2E emulador 2026-05-20 (v1.4.1):** ✅ — overflow → "Eliminar" abre `AlertDialog` "¿Eliminar lote?" con copy de cascada. UI verificada (no se confirmó el borrado para no perder el lote de prueba del resto del barrido). Bug auth-refresh ([[CU-11]]) ya cerrado.

## Bugs históricos relevantes
- **v0.3.0 backend** — endpoint `DELETE /v1/plots/:id` añadido (cerró el gap con `PlotsNotifier.deletePlot` del cliente móvil). Confirmar que cliente y backend están alineados. Ver backend CHANGELOG entrada `2026-05-20 — feat(plots delete) + docs(OpenAPI 3.0)`.
