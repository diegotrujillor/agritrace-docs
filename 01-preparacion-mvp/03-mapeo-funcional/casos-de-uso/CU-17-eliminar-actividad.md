# CU-17 — Eliminar actividad

| Campo | Valor |
|---|---|
| **ID** | CU-17 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego abre detalle de una actividad y toca el ícono de basurero, o usa "swipe-to-delete" en el item del timeline. |
| **Endpoints invocados** | `activitiesDelete` (`DELETE /v1/activities/{id}`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 9 (timeline) → diálogo → timeline sin el item. |
| **RFs cubiertos** | RF-03, RF-04. |

## Preconditions
- Diego está autenticado.
- Existe la actividad propia.
- Hay conexión a internet.

## Escenario principal (Main Success Scenario)
1. Diego está en **Pantalla 9** y toca un item del timeline para ver detalle.
2. Toca eliminar (basurero) → diálogo: "¿Eliminar esta actividad? Esta acción no se puede deshacer." + "Cancelar" / "Eliminar".
3. Toca **"Eliminar"** → mobile dispara `DELETE /v1/activities/{id}`.
4. Backend soft-deletea (`activities.deleted_at = NOW()`). Responde 200 `{ deleted: true }`.
5. UI cierra el detalle y el item desaparece del timeline; snackbar "Actividad eliminada".

## Flujos alternos
- **A. Cancelar diálogo** → no se llama endpoint.
- **B. Actividad ajena** → `403 ForbiddenError`.
- **C. Actividad ya eliminada** → `404 NotFoundError`.
- **D. Sin conexión** → snackbar "Sin conexión, intenta más tarde" (no se encola offline en MVP).
- **E. Swipe-to-delete** (si está implementado) → diálogo igual; sin diálogo de confirmación sería UX inaceptable.

## Postcondition
- `activities.deleted_at IS NOT NULL`.
- UI sin el item.
- Verificable: `SELECT deleted_at FROM activities WHERE id = '<id>';` → no nulo.

## Acceptance criteria (Given/When/Then)
- **Given** Diego tiene una actividad visible, **When** confirma eliminarla, **Then** la fila queda soft-deleted y el timeline ya no la muestra.
- **Given** Diego cancela el diálogo, **When** no toca confirmar, **Then** no hay request HTTP ni cambio.
- **Given** Diego intenta eliminar actividad ajena, **When** envía `DELETE`, **Then** recibe 403.

## Estado de prueba
- **Estado:** ❌ FALLA — UI ausente
- **Fecha de prueba:** 2026-05-20
- **Versión APK probada:** 1.3.6 (relevamiento de código, no alcanzable en emulador)
- **Notas de Diego (auto):**
  > Survey confirma: backend `DELETE /v1/activities/{id}` + `ActivityService.delete` + `activitiesProvider.delete` testeados, **pero no hay botón "Eliminar" ni swipe-to-delete** ni diálogo de confirmación en el timeline ni en la pantalla de detalle de actividad.
  > **Impacto MVP:** P2 — un productor podría querer revertir un registro mal hecho. Misma decisión que [[CU-16]]: ¿inmutable o editable? Si MVP es estricto sobre trazabilidad: dejar fuera de scope y documentar.
  > **Acción:** alinear con [[CU-16]]. Si se decide editable → agregar long-press menú con "Editar" / "Eliminar" + `AlertDialog`.

## Bugs históricos relevantes
- Ninguno documentado para este flujo en CHANGELOG.
