# CU-04 — Solicitar borrado de cuenta (ARCO derecho al olvido)

| Campo | Valor |
|---|---|
| **ID** | CU-04 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego toca **"Eliminar mi cuenta"** en la pantalla de perfil/ajustes. |
| **Endpoints invocados** | `usersDeleteMe` (`DELETE /v1/users/me`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 5 (Dashboard) → diálogo de confirmación → Pantalla 1 (Bienvenida). |
| **RFs cubiertos** | RNF-05 (Ley 1581 — derecho al olvido). |

## Preconditions
- Diego está autenticado.
- Hay conexión a internet.
- Diego tiene al menos 1 finca + 1 lote + 1 actividad para validar cascada.

## Escenario principal (Main Success Scenario)
1. Diego está en **Pantalla 5 — Dashboard**.
2. Abre menú de perfil → toca **"Eliminar mi cuenta"**.
3. Aparece un diálogo modal con texto claro: "Esto eliminará permanentemente tu cuenta, fincas, lotes, actividades y alertas. No se puede deshacer." + botones "Cancelar" / "Eliminar".
4. Diego toca **"Eliminar"** (idealmente con confirmación adicional tipo "escribe ELIMINAR" para evitar accidentes).
5. Mobile dispara `DELETE /v1/users/me` con el `accessToken`.
6. Backend ejecuta cascada (soft-delete o hard-delete según [`006_create_deletion_requests.sql`](../../../../agritrace-backend/src/db/migrations/006_create_deletion_requests.sql)): inserta fila en `deletion_requests`, marca `users.deleted_at`, cascada en `farms`/`plots`/`activities`/`alerts`. Responde `{ success: true, data: { deleted: true } }`.
7. Mobile borra tokens de `FlutterSecureStorage` y navega a `Routes.welcome` (Pantalla 1).
8. Snackbar de confirmación: "Cuenta eliminada".

## Flujos alternos
- **A. Cancelar el diálogo** → no se llama al endpoint; Diego sigue en Dashboard.
- **B. Sin conexión** → snackbar "Sin conexión, verifica tu internet". La solicitud **no** se encola offline (operación destructiva requiere confirmación servidor).
- **C. Token expirado** → `_AuthInterceptor` intenta refresh; si refresh también falla → app fuerza logout y redirige a Login.

## Postcondition
- `users.deleted_at IS NOT NULL` (o registro eliminado, según implementación).
- Cascada: `farms.deleted_at`, `plots.deleted_at`, `activities.deleted_at`, `alerts.deleted_at` para todas las filas del productor.
- Fila en `deletion_requests` con `requested_at` y `completed_at`.
- `FlutterSecureStorage` vacío.
- UI en Pantalla 1.
- Verificable: `SELECT email, deleted_at FROM users WHERE id = '<userId>';` → `deleted_at` no nulo.

## Acceptance criteria (Given/When/Then)
- **Given** Diego está autenticado con datos, **When** confirma "Eliminar mi cuenta", **Then** todos sus datos quedan soft-deleted y la app va a Bienvenida.
- **Given** la cuenta fue eliminada, **When** Diego intenta login con esas credenciales, **Then** backend responde 401 (cuenta inactiva/eliminada).
- **Given** la cuenta fue eliminada, **When** se consulta `deletion_requests`, **Then** existe fila con `user_id` correspondiente y timestamp completado.
- **Given** Diego cancela el diálogo, **When** no toca confirmar, **Then** no hay request HTTP ni cambio de UI.

## Estado de prueba
- **Estado:** 🟡 pendiente
- **Fecha de prueba:**
- **Versión APK probada:**
- **Notas de Diego:**
  > <espacio para anotar lo observado> — usar al final de cada sesión de QA para limpiar el ambiente.

## Bugs históricos relevantes
- Ninguno documentado para este flujo en CHANGELOG (endpoint existe desde Sprint 1; UX puede no estar pulido).
