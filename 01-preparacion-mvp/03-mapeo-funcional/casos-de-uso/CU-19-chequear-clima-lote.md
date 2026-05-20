# CU-19 — Chequear clima del lote → genera alerta weather si umbral cruzado

| Campo | Valor |
|---|---|
| **ID** | CU-19 |
| **Actor primario** | Productor |
| **Prioridad MVP** | SHOULD |
| **Disparador** | Diego toca **"Consultar clima"** en la Pantalla 9 (Vista lote) o en la lista de alertas. |
| **Endpoints invocados** | `alertsWeatherCheck` (`POST /v1/alerts/weather/check`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 9 (Vista lote) o pantalla de Alertas → resultado en snackbar/diálogo → lista de alertas actualizada. |
| **RFs cubiertos** | RF-10 (alertas climáticas si hay API de clima). |

## Preconditions
- Diego está autenticado.
- Existe el lote propio con `latitude` y `longitude` no nulas (de lo contrario el provider de clima no puede consultar).
- Hay conexión a internet.
- Backend tiene `WEATHER_PROVIDER` configurado (`none` / `stub` / real). Ver backend CHANGELOG entrada `Sprint 4: alertas + notificaciones + sync hardening`.

## Escenario principal (Main Success Scenario)
1. Diego está en **Pantalla 9** y toca **"Consultar clima"**.
2. Mobile dispara `POST /v1/alerts/weather/check` con `{ plotId }`.
3. Backend resuelve coords del lote, llama al provider de clima (en MVP: `stub` retorna lluvia/temperatura simulada). Si el resultado cruza un umbral (ej. probabilidad de lluvia >70%, temperatura >35°C), inserta una fila nueva en `alerts` con `type='weather'`, `severity='warning'|'severe'`, `status='pending'`.
4. Backend responde 200 con `{ alertCreated: boolean, alert?: Alert, weather: {...} }`.
5. Si se creó alerta → mobile muestra snackbar "Alerta climática creada" + abre/refresca la lista de alertas.
6. Si no se creó → snackbar "Clima estable, sin alertas".

## Flujos alternos
- **A. Lote sin coordenadas** → backend responde `400 ValidationError` o `404 NotFoundError` (latitude/longitude requeridos). UX: "Añade coordenadas al lote para poder consultar el clima".
- **B. Lote ajeno** → `403`.
- **C. Provider externo caído** (real) → backend retorna 200 con `weather=null` o 503 según implementación; UX muestra "No se pudo consultar el clima, intenta más tarde".
- **D. Sin conexión** → snackbar "Sin conexión"; no se encola offline (depende de fuente externa).

## Postcondition
- Si umbral cruzado: nueva fila en `alerts` (`type='weather'`).
- Notificación best-effort vía canal `log` (o SMS si está configurado) — no revierte la alerta si falla. Ver `notification.service`.
- Verificable: `SELECT id, type, severity, status FROM alerts WHERE producer_id = '<producerId>' AND type='weather' ORDER BY created_at DESC LIMIT 1;`.

## Acceptance criteria (Given/When/Then)
- **Given** el lote tiene coords y el stub devuelve "lluvia 80%", **When** Diego toca "Consultar clima", **Then** se crea una alerta `weather` con `severity='warning'` y aparece en la lista en ≤3 s.
- **Given** el lote sin coords, **When** Diego intenta consultar, **Then** la UI lo guía a editar el lote y añadir coords.
- **Given** el stub devuelve clima estable, **When** Diego consulta, **Then** **no** se crea alerta y la UI lo informa explícitamente.

## Estado de prueba
- **Estado:** ✅ pasa (v1.4.0) — manual trigger; cron/provider real pendiente post-pilot
- **Fecha de prueba:** 2026-05-20
- **Versión APK probada:** 1.4.0 (CI commit `d04824a`)
- **Notas de Diego (auto):**
  > Shipping: acción "Actualizar clima" en AppBar de `alerts_screen` con spinner inline + snackbar "Clima actualizado · N alertas nuevas" / mensaje de error en rojo. `AlertsNotifier.runWeatherCheckForAllPlots(plotIds)` agrega un loop sobre lotes del usuario + invalidación de lista. Commit `9d64d5f` en main.
  > **Tests:** `test/widget/alerts_screen_weather_check_test.dart` — 3 casos (1 call por lote, happy path con spinner observable, error path con snackbar rojo y lista intacta).
  > **Backend:** `WEATHER_PROVIDER=stub` sigue activo en prod (genera alerta sintética). El switch a `openweathermap` real + cron son decisiones post-pilot documentadas en CHANGELOG.
  > **Retest E2E:** pendiente al desbloquear [[CU-11]].

## Bugs históricos relevantes
- Ninguno documentado en CHANGELOG. (Provider real pendiente de configurar — el MVP usa `stub`.)
