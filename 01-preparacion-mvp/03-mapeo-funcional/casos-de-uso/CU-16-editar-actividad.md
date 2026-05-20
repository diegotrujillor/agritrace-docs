# CU-16 — Editar actividad (fecha, descripción, foto)

| Campo | Valor |
|---|---|
| **ID** | CU-16 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego toca un item del timeline y luego el lápiz de edición. |
| **Endpoints invocados** | `activitiesGetById` (`GET /v1/activities/{id}`), `activitiesUpdate` (`PUT /v1/activities/{id}`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 9 → detalle de actividad → form (reuso Pantalla 10) → Pantalla 9 con la actividad actualizada. |
| **RFs cubiertos** | RF-03, RF-04. |

## Preconditions
- Diego está autenticado.
- Existe la actividad propia.
- Hay conexión a internet (o sync diferido CU-23).

## Escenario principal (Main Success Scenario)
1. Diego está en **Pantalla 9** y toca un item del timeline.
2. App muestra detalle de la actividad (en modal o pantalla); Diego toca el lápiz.
3. Form se abre con valores pre-cargados (tipo, fecha, descripción, foto).
4. Cambia la **fecha** (date picker), la **descripción** o reemplaza la **foto**.
5. Toca **"Guardar"** → mobile dispara `PUT /v1/activities/{id}` con `UpdateActivityInput` (al menos 1 campo).
6. Backend valida, actualiza `activities.updated_at`, responde 200.
7. UI vuelve al timeline; el item refleja los cambios; si la fecha cambió, el item puede reordenarse.

## Flujos alternos
- **A. Body vacío** → `400 ValidationError` (regla `minProperties: 1`).
- **B. Actividad ajena** → `403 ForbiddenError`.
- **C. Actividad inexistente / soft-deleted** → `404 NotFoundError`.
- **D. Sin conexión** → cambio guardado local con `_status='updated'`; sync diferido (CU-23).
- **E. Reemplazar foto offline** → la foto vieja queda en cache local hasta el próximo sync; la nueva apunta a URI local.

## Postcondition
- Fila `activities` con campo(s) actualizado(s) y `updated_at` nuevo.
- UI muestra los valores nuevos en el timeline.
- Verificable: `SELECT type, occurred_at, description, updated_at FROM activities WHERE id = '<id>';`.

## Acceptance criteria (Given/When/Then)
- **Given** Diego edita la descripción de una actividad, **When** guarda con conexión, **Then** el item del timeline muestra la nueva descripción en ≤2 s.
- **Given** Diego cambia la fecha a una más antigua, **When** guarda, **Then** el item se reordena al bottom del timeline.
- **Given** sin conexión, **When** Diego edita, **Then** el item queda con `_status='updated'` y se sincroniza al reconectar (LWW por `updated_at`).

## Estado de prueba
- **Estado:** 🟡 pendiente
- **Fecha de prueba:**
- **Versión APK probada:**
- **Notas de Diego:**
  > <espacio para anotar lo observado>

## Bugs históricos relevantes
- Ninguno documentado para este flujo en CHANGELOG.
