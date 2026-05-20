# CU-21 — Descartar/eliminar alerta

| Campo | Valor |
|---|---|
| **ID** | CU-21 |
| **Actor primario** | Productor |
| **Prioridad MVP** | SHOULD |
| **Disparador** | Diego toca "Descartar" (swipe / botón) o "Eliminar" en un item de la lista de alertas. |
| **Endpoints invocados** | `alertsUpdate` (`PATCH /v1/alerts/{id}` con `status='dismissed'`) o `alertsDelete` (`DELETE /v1/alerts/{id}`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla de Alertas (`Routes.alerts`). |
| **RFs cubiertos** | RF-09, RF-10. |

## Preconditions
- Diego está autenticado.
- Existe ≥1 alerta propia.
- Hay conexión a internet.

## Escenario principal — Descartar (no borrar)
1. Diego está en la lista de alertas.
2. Swipe-left en un item → aparece acción "Descartar".
3. Toca **"Descartar"** → mobile dispara `PATCH /v1/alerts/{id}` con `{ status: 'dismissed' }`.
4. Backend valida (Zod), actualiza `alerts.status='dismissed'`, responde 200.
5. UI mueve el item al final de la lista (o lo oculta si el filtro por defecto es "pending only"); snackbar "Alerta descartada".

## Escenario alterno — Eliminar (soft-delete)
1. Diego toca el item para abrir detalle → toca basurero → diálogo confirmación.
2. Toca **"Eliminar"** → mobile dispara `DELETE /v1/alerts/{id}`.
3. Backend soft-deletea (`alerts.deleted_at = NOW()`), responde 200.
4. UI quita el item de la lista; snackbar "Alerta eliminada".

## Flujos alternos
- **A. Alerta ajena** → 403.
- **B. Alerta ya eliminada** → 404.
- **C. Sin conexión** → cambio queda local con `_status='updated'` (descartar) o no se ejecuta (eliminar — no se encola).
- **D. Cancelar diálogo de eliminar** → no se llama endpoint.

## Postcondition
- **Descartar:** `alerts.status='dismissed'`, `updated_at` nuevo.
- **Eliminar:** `alerts.deleted_at IS NOT NULL`.
- UI refleja el cambio.

## Acceptance criteria (Given/When/Then)
- **Given** una alerta con `status='pending'`, **When** Diego la descarta, **Then** la fila pasa a `status='dismissed'` sin desaparecer físicamente.
- **Given** una alerta visible, **When** Diego la elimina y confirma, **Then** `deleted_at` queda no nulo y el item desaparece del listado.
- **Given** Diego cancela el diálogo de eliminar, **When** no toca confirmar, **Then** no hay cambio.

## Estado de prueba
- **Estado:** ⚠️ pasa con notas — UI existe; retest E2E pendiente al desbloquear [[CU-18]]
- **Fecha de prueba:** 2026-05-20
- **Versión APK probada:** 1.3.6
- **Notas de Diego (auto):**
  > Survey confirma: backend `POST /v1/alerts/{id}/dismiss` + `DELETE /v1/alerts/{id}` + `AlertService.dismiss/delete` + `AlertsNotifier` testeados. `alerts_screen.dart` expone acción "Descartar" / "Eliminar" por ítem (swipe o long-press).
  > **Pendiente E2E:** una vez exista al menos 1 alerta en lista vía [[CU-18]] o [[CU-19]], probar:
  >   1. Descartar → ítem desaparece del feed activo.
  >   2. Eliminar → ítem desaparece definitivo, no vuelve tras pull-to-refresh.
  > **Acción:** marcar ✅ pasa una vez completado E2E con v1.3.6.

## Bugs históricos relevantes
- Ninguno documentado en CHANGELOG.
