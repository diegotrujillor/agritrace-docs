# CU-18 — Crear recordatorio manual con scheduled_for

| Campo | Valor |
|---|---|
| **ID** | CU-18 |
| **Actor primario** | Productor |
| **Prioridad MVP** | SHOULD |
| **Disparador** | Diego toca **"+"** o **"Nuevo recordatorio"** en la pantalla de Alertas. |
| **Endpoints invocados** | `alertsCreate` (`POST /v1/alerts`) con `type=reminder` + `scheduledFor` obligatorio — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Dashboard → Alertas (`Routes.alerts`) → Form alerta (`Routes.alertNew`) → lista de alertas con el item nuevo. |
| **RFs cubiertos** | RF-09 (alertas locales de actividades programadas — recordatorios). |

## Preconditions
- Diego está autenticado.
- Hay conexión a internet (la creación se persiste server-side).

## Escenario principal (Main Success Scenario)
1. Diego está en **Pantalla 5 — Dashboard** y toca el atajo "Alertas" en el AppBar → navega a `Routes.alerts`.
2. Toca **"Nuevo recordatorio"** (FAB "+") → navega a `Routes.alertNew`.
3. Diligencia:
   - Título (1-160 chars).
   - Fecha/hora programada (`scheduledFor`, `AppDateField` con time picker).
   - Cuerpo / nota (opcional, ≤4000 chars).
   - (Opcional) `plotId` si el recordatorio es específico de un lote.
4. Toca **"Guardar"** → mobile dispara `POST /v1/alerts` con `type='reminder'`, `title`, `scheduledFor`, `body?`, `plotId?`.
5. Backend valida (Zod: `type=reminder` requiere `scheduledFor`), inserta fila en `alerts` con `status='pending'`. Responde 201.
6. Mobile vuelve a la lista de alertas; el recordatorio aparece con badge "pendiente".

## Flujos alternos
- **A. `scheduledFor` ausente con `type=reminder`** → `400 ValidationError`.
- **B. `plotId` de lote ajeno** → `403 ForbiddenError`.
- **C. Fecha pasada** → la API la acepta (no hay constraint server-side); UX debería advertir "Fecha en el pasado, ¿continuar?".
- **D. Sin conexión** → la alerta queda en WatermelonDB local con `_status='created'`; sync diferido.

## Postcondition
- Fila nueva en `alerts` con `type='reminder'`, `severity='info'` (default), `status='pending'`, `scheduled_for` correcto.
- UI rinde el item en la lista.
- Verificable: `SELECT id, type, status, scheduled_for FROM alerts WHERE producer_id = '<producerId>' AND type='reminder';`. Ver [`011_create_alerts.sql`](../../../../agritrace-backend/src/db/migrations/011_create_alerts.sql).

## Acceptance criteria (Given/When/Then)
- **Given** Diego tiene un título + fecha futura, **When** guarda con conexión, **Then** el recordatorio aparece en la lista con badge "pendiente".
- **Given** olvida la fecha, **When** intenta guardar, **Then** Zod rechaza con 400 y la UI muestra error inline en el campo Fecha.
- **Given** sin conexión, **When** Diego guarda, **Then** queda local con `_status='created'` y sincroniza al reconectar.

## Estado de prueba
- **Estado:** ⚠️ pasa con notas — fix P1 ISO UTC en v1.3.6 cubre este flujo, retest pendiente
- **Fecha de prueba:** 2026-05-20
- **Versión APK probada:** 1.3.5 (bug reproducido en código), fix shipping en v1.3.6
- **Notas de Diego (auto):**
  > Survey confirma: pantalla `alert_create_screen` (form de recordatorio) existe, backend `POST /v1/alerts/reminders` testeado, `AlertService.createReminder` testeado. **Mismo bug que [[CU-14]]:** `scheduledFor` enviaba `DateTime.now().toIso8601String()` sin sufijo `Z` → backend Zod 400 silencioso.
  > **Fix v1.3.6** (commit `8c3a551`): `alert_service.dart` → `scheduledFor: scheduledFor.toUtc().toIso8601String()`.
  > **Acción:** una vez v1.3.6 instalado, crear recordatorio "Fertilizar Lote A" 2 días en el futuro, validar que aparece en [[CU-20]] lista de alertas. Si OK → ✅.

## Bugs históricos relevantes
- Ninguno documentado para este flujo en CHANGELOG.
