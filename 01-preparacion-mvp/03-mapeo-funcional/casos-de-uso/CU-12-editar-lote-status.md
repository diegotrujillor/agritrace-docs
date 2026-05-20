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
- **Estado:** ❌ FALLA — UI ausente
- **Fecha de prueba:** 2026-05-20
- **Versión APK probada:** 1.3.5 (relevamiento de código, no se reprodujo en emulador porque la acción no es alcanzable)
- **Notas de Diego (auto):**
  > Survey de código confirma: backend `PUT /v1/plots/{id}` + `PlotService.update` + `plotsProvider` existen y están testeados, **pero la pantalla de detalle del lote (`plot_detail_screen.dart`) no expone botón "Editar"** y no hay `plot_edit_screen` ni ruta `/plots/:id/edit` registradas en `app_router.dart`.
  > **Impacto MVP:** P1 — Diego no puede corregir estado/área/cultivo sin borrar+recrear (también bloqueado, ver [[CU-13]]).
  > **Acción:** crear `plot_edit_screen.dart` reusando el form de `plot_create_screen` + ruta + botón "Editar" en plot-detail. Issue a abrir antes del pilot.

## Bugs históricos relevantes
- Ninguno documentado para este flujo en CHANGELOG.
