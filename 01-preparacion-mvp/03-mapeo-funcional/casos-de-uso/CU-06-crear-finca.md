# CU-06 — Crear finca con cultivo + área + coordenadas opcionales

| Campo | Valor |
|---|---|
| **ID** | CU-06 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego toca **"Registrar finca"** en la Pantalla 4 (Dashboard vacío) o el botón flotante "+" en la Pantalla 5. |
| **Endpoints invocados** | `farmsCreate` (`POST /v1/farms`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 4/5 (Dashboard) → Pantalla 6 (Registrar finca) → Pantalla 7 (Vista finca). Rutas: `Routes.dashboard` → `Routes.farmsNew` → `Routes.farmDetail(<id>)`. |
| **RFs cubiertos** | RF-01 (perfil productor), RF-07 (múltiples fincas con GPS). |

## Preconditions
- Diego está autenticado.
- Hay conexión a internet (para coordenadas GPS y sync inmediato; el form **debe** funcionar offline si CU-22 está implementado).

## Escenario principal (Main Success Scenario)
1. Diego está en **Pantalla 4 — Dashboard vacío** ("Aún no has registrado una finca").
2. Toca **"Registrar finca"** → navega a `Routes.farmsNew` (**Pantalla 6 — Registrar finca**).
3. Diligencia el formulario:
   - Nombre de la finca (2-255 chars).
   - Cultivo principal (dropdown o texto, 2-50 chars).
   - Área en hectáreas (opcional, decimal positivo).
   - Dirección/municipio (opcional, ≤255 chars).
   - Coordenadas (opcional): toca **"Obtener ubicación"** → app pide permiso de ubicación → se llenan `latitude` + `longitude`.
4. Toca **"Guardar"** → mobile dispara `POST /v1/farms` con el payload.
5. Backend valida (Zod), inserta fila en `farms` con `producer_id` del JWT. Responde `201` con el `Farm`.
6. Mobile navega a `Routes.farmDetail(farm.id)` (**Pantalla 7 — Vista finca**).
7. Snackbar: "Finca guardada".

## Flujos alternos
- **A. Permiso de ubicación denegado** → app muestra mensaje "Sin coordenadas; podrás añadirlas después editando". Diego continúa sin GPS.
- **B. Nombre <2 chars** o **cultivo vacío** → Zod falla → `400 ValidationError` → mensaje inline en el campo.
- **C. Sin conexión** → la app guarda la finca localmente (WatermelonDB, `_status='created'`), muestra snackbar "Guardado localmente, se sincronizará". Ver CU-22.
- **D. Token expirado** → `_AuthInterceptor` refresca; si falla, redirige a Login.

## Postcondition
- Fila nueva en `farms` (online) o en WatermelonDB local (offline).
- UI muestra Pantalla 7 con la finca recién creada (mapa/coordenadas si se obtuvieron, lista de lotes vacía).
- Verificable en DB: `SELECT id, name, crop_type, latitude, longitude FROM farms WHERE producer_id = '<producerId>';`. Ver [`008_create_farms.sql`](../../../../agritrace-backend/src/db/migrations/008_create_farms.sql).

## Acceptance criteria (Given/When/Then)
- **Given** Diego está en Pantalla 6 con datos válidos, **When** toca "Guardar" con conexión, **Then** la finca queda en `farms` y la UI muestra Pantalla 7 en ≤2 s.
- **Given** Diego no concede permiso de ubicación, **When** guarda sin coordenadas, **Then** la finca se crea con `latitude=null`, `longitude=null` (campos opcionales).
- **Given** no hay conexión, **When** Diego guarda, **Then** la finca queda en WatermelonDB local con `_status='created'` y la UI igualmente navega a Pantalla 7.

## Estado de prueba
- **Estado:** ✅ pasa (en v1.3.4) — previamente ❌ P1 en v1.3.3
- **Fecha de prueba:** 2026-05-20
- **Versión APK probada:** **1.3.4** (release APK con fix)
- **Entorno:** emulador Android 14, Pixel 7 Pro AVD, arm64-v8a; backend v0.4.1.
- **Notas de Diego (auto):**
  > **Re-test post-fix v1.3.4:** llené el form (Nombre "Finca v134", cultivo "cacao", área 7) + tap **Registrar finca** → form se cerró, navegué a Dashboard, finca aparece en la lista con tarjeta "Finca v134 / cacao · 7 ha". **Sin banner de error.** FAB "+" disponible para siguiente.
  > **Historial del bug (v1.3.3):** los FAB "+" usaban `context.go(form)` (REPLACE en go_router 14), dejando la pila vacía. Form llamaba `context.pop()` tras 201 → `GoError('There is nothing to pop')` atrapado silenciosamente → banner genérico. **Backend SÍ creaba la fila** — 3 taps = 3 duplicados.
  > **Fix v1.3.4:** 6 sitios cambiados `context.go` → `context.push` (dashboard FAB, farm-detail edit + FAB, plot-detail FAB, activity-timeline FAB, alerts FAB). Test de regresión `form_nav_regression_test.dart` ancla el patrón push-then-pop para los 4 CRUD chains.
  > **Cobertura del fix:** alivia CU-06 (crear finca) y por el mismo patrón debería arreglar CU-10 (crear lote), CU-12 (editar lote), CU-14 (registrar actividad), CU-18 (crear alerta). Re-testear cada uno.

## Bugs históricos relevantes
- Ninguno específico a este flujo. (Validar UX del botón "Obtener ubicación" — el v1.3.3 no menciona fixes en esta pantalla.)
