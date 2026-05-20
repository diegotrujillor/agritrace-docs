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
- **Estado:** ❌ FALLA — **P1 BLOQUEADOR**
- **Fecha de prueba:** 2026-05-20
- **Versión APK probada:** 1.3.3 (release APK)
- **Entorno:** emulador Android 14, Pixel 7 Pro AVD, arm64-v8a; backend v0.4.1.
- **Notas de Diego (auto):**
  > **Síntoma:** llenar form (Nombre "Finca QA", cultivo "cacao", área 5) + tap **Registrar finca** → muestra banner "Ocurrió un error, intenta de nuevo" y **permanece en el form**.
  > **Realidad:** `POST /v1/farms` 201 y la fila SÍ se crea en DB. Verificado por SSH + `SELECT * FROM farms` — fila presente con campos correctos. 3 intentos consecutivos crearon 3 filas duplicadas en DB.
  > **Pase de curl con payload idéntico desde laptop:** 201 y JSON válido devuelto. Backend OK.
  > **Conclusión:** bug en el cliente — la excepción se lanza DESPUÉS del 201, en el parseo de la respuesta o en el `_refresh()` que sigue. No es un DioException (logcat no muestra rastro). Cae al fallback genérico de `parseApiError`. El `_submit` catch silenciosamente swallow del error sin print/logger → invisible en logcat.
  > **Hipótesis principal:** algo en `Farm.fromJson` o en `unwrapEnvelope` truena con el JSON real. Posiblemente `address: null` cast a `String?`, `areaHectares: 5` (int) → toDoubleOrNull, o un campo nuevo (`producerId`, `updatedAt`) que el modelo no maneja. Necesita repro con `flutter run --debug` y `debugPrint(error.toString())` en el catch.
  > **Impacto Sprint 5:** **BLOQUEA TODA LA CADENA DE FINCA/LOTE/ACTIVIDAD** — todo flow CRUD que use `farmsProvider.create` / `update` / `delete` muestra error genérico al usuario aunque el backend procese correctamente. Productores creerán que la app no funciona. **No se puede arrancar piloto con esto vivo.**
  > **Fix prioritario:** añadir `debugPrint('FARM CREATE ERROR: $error\n$stacktrace')` en `lib/screens/farms/farm_form_screen.dart:91` catch, build APK debug, repetir el flow, capturar excepción exacta. Luego corregir.
  > **Mismo patrón probable en:** `lib/providers/{plots,activities,alerts}_provider.dart` create/update/delete — todos usan el mismo `unwrapOne` + Model.fromJson. Riesgo de fallar también CU-10 (crear lote), CU-14 (registrar actividad), CU-18 (crear alerta).

## Bugs históricos relevantes
- Ninguno específico a este flujo. (Validar UX del botón "Obtener ubicación" — el v1.3.3 no menciona fixes en esta pantalla.)
