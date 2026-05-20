# CU-22 — Trabajar offline sin pérdida (registros locales)

| Campo | Valor |
|---|---|
| **ID** | CU-22 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego enciende **modo avión** o se desplaza a zona sin red. |
| **Endpoints invocados** | Ninguno (todo se persiste en WatermelonDB local hasta CU-23). |
| **Pantallas** | Todas las pantallas del Flow A (4-10). `OfflineIndicator` visible en el AppBar. |
| **RFs cubiertos** | RF-05 (14+ días offline), RF-06 (sync posterior), RNF-02 (offline-first). |

## Preconditions
- Diego está autenticado (tokens guardados, no expirados — los tokens de 15 min se renuevan automáticamente cuando hay red).
- WatermelonDB local inicializado.
- APK v1.3.3 con `connectivity_plus` activo.

> Nota: el scope MVP exige garantizar **≥14 días offline** ([`09-scope-mvp.md §3`](../../09-scope-mvp.md)). El piloto Sprint 5 es 30 días; este CU prueba la capacidad de uso continuo sin red durante ese horizonte, no necesariamente que Diego no abra la app con red en 30 días.

## Escenario principal (Main Success Scenario)
1. Diego activa **modo avión** en el Pixel.
2. La app detecta `ConnectivityResult.none` → muestra el `OfflineIndicator` (banda naranja arriba con texto "Sin conexión") y el `SyncStatusBadge` cambia a "Offline".
3. Durante el periodo offline Diego hace:
   - Crear finca (CU-06) → fila local `_status='created'`.
   - Crear lote (CU-10) → fila local `_status='created'`.
   - Crear 3 actividades (CU-14) con fotos (URI local) → filas locales `_status='created'`.
   - Editar finca (CU-08) → fila local `_status='updated'`.
   - Crear recordatorio (CU-18) → fila local `_status='created'`.
4. Toda la información se ve correctamente en la UI (lectura desde WatermelonDB local). El `SyncStatusBadge` indica "N cambios pendientes".

## Flujos alternos
- **A. Acceso al detalle de algo aún no sincronizado** → la UI funciona igual; el id local (UUID generado client-side) sirve hasta el sync.
- **B. Refresh token expira durante un periodo prolongado** (7 días) → al reconectar, `_AuthInterceptor` no podrá refrescar; la app fuerza re-login. **Limitación conocida MVP**; en el piloto Diego debe sincronizar al menos cada 7 días.
- **C. App se cierra y se reabre offline** → al reabrir, WatermelonDB conserva los datos pendientes; el dashboard rinde todo correctamente.

## Postcondition
- WatermelonDB local tiene N filas con `_status IN ('created','updated')`.
- Backend **sin cambios** (no se ha sincronizado).
- Verificable abriendo la app y revisando que toda la data esté visible y consistente offline.

## Acceptance criteria (Given/When/Then)
- **Given** Diego está offline, **When** crea/edita fincas/lotes/actividades/alertas, **Then** todas las operaciones tienen éxito y se persisten en WatermelonDB con `_status` correcto.
- **Given** la app se cierra y se reabre sin red, **When** Diego entra al Dashboard, **Then** ve todos los datos creados/editados offline.
- **Given** ha pasado >14 días sin red pero <7 días sin sincronizar, **When** Diego sigue trabajando, **Then** ninguna acción se pierde y el `SyncStatusBadge` indica los cambios pendientes.

## Estado de prueba
- **Estado:** 🟡 pendiente
- **Fecha de prueba:**
- **Versión APK probada:**
- **Notas de Diego:**
  > <espacio para anotar lo observado> — para smoke-test ejecutar al menos 30 min en modo avión con varias operaciones; los 14 días reales se validan en el piloto Sprint 5.

## Bugs históricos relevantes
- **v1.3.2** — la app interpretaba mal el estado offline por falta del permiso `INTERNET`. Confirmar que `OfflineIndicator` aparece **solo** cuando el dispositivo realmente está sin red (no como falso positivo). Ver CHANGELOG mobile entrada `2026-05-19 — fix: sin red en APK release`.
