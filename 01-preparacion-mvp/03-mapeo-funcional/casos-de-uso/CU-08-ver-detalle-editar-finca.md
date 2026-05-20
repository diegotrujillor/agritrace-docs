# CU-08 — Ver detalle de finca + editar

| Campo | Valor |
|---|---|
| **ID** | CU-08 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego toca una tarjeta de finca en la Pantalla 5 (Dashboard). |
| **Endpoints invocados** | `farmsGetById` (`GET /v1/farms/{id}`), `farmsUpdate` (`PUT /v1/farms/{id}`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 5 → Pantalla 7 (Vista finca) → form de edición (modal o reuso de Pantalla 6). Ruta: `Routes.farmDetail(<id>)`. |
| **RFs cubiertos** | RF-01, RF-07. |

## Preconditions
- Diego está autenticado.
- Existe ≥1 finca propia.
- Hay conexión a internet (para `PUT`; lectura puede ser offline desde WatermelonDB).

## Escenario principal (Main Success Scenario)
1. Diego está en **Pantalla 5 — Dashboard**.
2. Toca una tarjeta de finca → navega a `Routes.farmDetail(<id>)` (**Pantalla 7 — Vista finca**).
3. Mobile dispara `GET /v1/farms/{id}` y rinde:
   - Nombre.
   - Cultivo principal.
   - Área en hectáreas (si existe).
   - Coordenadas + mapa estático (si existen).
   - Dirección.
   - Lista de lotes (vacía o con tarjetas).
   - Botón **"Registrar lote"**.
4. Diego toca el botón de editar (icono lápiz en AppBar) → se abre el form con los datos actuales pre-cargados.
5. Cambia, por ejemplo, el nombre o el cultivo.
6. Toca **"Guardar"** → mobile dispara `PUT /v1/farms/{id}` con `UpdateFarmInput` (al menos 1 campo).
7. Backend valida (Zod), actualiza `farms` con `updated_at = NOW()`, responde 200 con el Farm actualizado.
8. UI vuelve a Pantalla 7 con los nuevos valores; snackbar "Finca actualizada".

## Flujos alternos
- **A. Finca de otro productor** (URL manipulada) → backend responde `403 ForbiddenError` → snackbar "Sin permiso".
- **B. Finca no existe** → `404 NotFoundError` → la app navega de regreso al Dashboard con snackbar "Finca no encontrada".
- **C. Body de edición vacío** → Zod (`minProperties: 1`) falla → 400 → snackbar "Cambia al menos un campo".
- **D. Sin conexión durante editar** → cambios se guardan en WatermelonDB local con `_status='updated'`, se sincronizan después (CU-23).

## Postcondition
- Fila `farms` con `updated_at` actualizado y los campos cambiados.
- UI muestra los valores nuevos.
- Verificable: `SELECT name, crop_type, updated_at FROM farms WHERE id = '<id>';`.

## Acceptance criteria (Given/When/Then)
- **Given** Diego está en Pantalla 7, **When** edita el nombre y guarda, **Then** la fila en `farms` cambia y la UI muestra el nuevo nombre en ≤2 s.
- **Given** Diego intenta acceder a una finca ajena, **When** mobile llama `GET /v1/farms/{id}`, **Then** recibe 403 (no 404) — confirma que el ownership check funciona.
- **Given** no hay conexión, **When** Diego edita, **Then** el cambio queda en WatermelonDB local con `_status='updated'` y se sincroniza al reconectar.

## Estado de prueba
- **Estado:** 🟡 pendiente
- **Fecha de prueba:**
- **Versión APK probada:**
- **Notas de Diego:**
  > <espacio para anotar lo observado>

## Bugs históricos relevantes
- Ninguno documentado en CHANGELOG.
