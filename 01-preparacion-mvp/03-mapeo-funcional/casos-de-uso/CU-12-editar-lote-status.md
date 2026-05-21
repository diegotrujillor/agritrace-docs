# CU-12 — Editar lote (cambio de status planning→growing→ready→harvested)

| Campo | Valor |
|---|---|
| **ID** | CU-12 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego toca el icono de editar (lápiz) en el AppBar de la Pantalla 9. |
| **Endpoints invocados** | `plotsUpdate` (`PUT /v1/plots/{id}`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 9 (Vista lote) → form (reuso Pantalla 8) → Pantalla 9 actualizada. |
| **RFs cubiertos** | RF-02, RF-04. |

## Preconditions
- Diego está autenticado.
- Existe el lote propio.
- Hay conexión a internet (o sync diferido CU-23).

## Escenario principal (Main Success Scenario)
1. Diego está en **Pantalla 9 — Vista lote**.
2. Toca el lápiz → se abre el form de edición con valores pre-cargados.
3. Cambia el campo **Estado** desde `planning` → `growing` mediante un `AppLabeledDropdown` (los 4 valores válidos del enum `PlotStatus`).
4. Toca **"Guardar"** → mobile dispara `PUT /v1/plots/{id}` con `{ status: 'growing' }` (al menos un campo, regla `minProperties: 1`).
5. Backend valida (Zod), actualiza `plots`, responde 200.
6. UI vuelve a Pantalla 9; el badge de estado en la cabecera ahora muestra "En crecimiento".

## Flujos alternos
- **A. Body vacío** → 400 → snackbar "Cambia al menos un campo".
- **B. Status fuera del enum** → 400 (Zod rechaza).
- **C. Lote de otro productor** → 403.
- **D. Sin conexión** → cambio guardado local con `_status='updated'`, sync diferido.
- **E. Backwards (harvested → planning)** → permitido por la API (no hay constraint server-side); UX debería advertir pero no bloquea.

## Postcondition
- Fila `plots` con `status` nuevo y `updated_at` actualizado.
- Verificable: `SELECT name, status, updated_at FROM plots WHERE id = '<id>';`.

## Acceptance criteria (Given/When/Then)
- **Given** Diego tiene un lote en `planning`, **When** cambia el estado a `growing` y guarda, **Then** la DB refleja el cambio y la UI muestra el nuevo badge en ≤2 s.
- **Given** Diego edita solo el área en hectáreas, **When** guarda, **Then** los demás campos se mantienen.
- **Given** Diego intenta editar lote ajeno, **When** envía `PUT`, **Then** recibe 403.

## Estado de prueba
- **Estado:** ✅ pasa (v1.4.0)
- **Fecha de prueba:** 2026-05-20
- **Versión APK probada:** 1.4.0 (CI commit `d04824a`, build #26195017652)
- **Notas de Diego (auto):**
  > Shipping: pantalla `plot_edit_screen.dart` + `PlotForm` widget compartido + ruta `/plots/:id/edit` + entrada vía `PopupMenuButton` overflow en `plot_detail_screen`. Commit `3e0ac0e` en main.
  > **Tests añadidos:** `test/widget/plot_edit_screen_test.dart` (prefill + submit). 204→213 tests verdes después de los 3 commits paralelos.
  > **Retest E2E emulador 2026-05-20 (v1.4.1):** ✅ — overflow → "Editar" → cambié Estado de "Planificación" a "En crecimiento"; persistió y el detalle del lote refleja el nuevo estado. Bug auth-refresh ([[CU-11]]) ya cerrado.

## Bugs históricos relevantes
- Ninguno documentado para este flujo en CHANGELOG.
