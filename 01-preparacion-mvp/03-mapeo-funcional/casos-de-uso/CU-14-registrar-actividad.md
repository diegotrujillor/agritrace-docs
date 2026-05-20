# CU-14 — Registrar actividad (los 6 tipos)

| Campo | Valor |
|---|---|
| **ID** | CU-14 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego toca **"Registrar actividad"** en la Pantalla 9 (Vista lote). |
| **Endpoints invocados** | `activitiesCreate` (`POST /v1/activities`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 9 → Pantalla 10 (Registrar actividad) → Pantalla 9 con la actividad nueva en el timeline. Rutas: `Routes.plotDetail(<plotId>)` → `Routes.activityNew(<plotId>)`. |
| **RFs cubiertos** | RF-03 (registrar actividades con fecha, notas, fotos), RF-05 (offline-first), RF-04 (timeline). |

## Preconditions
- Diego está autenticado.
- Existe el lote propio (CU-10).
- Hay conexión a internet **o** WatermelonDB local (modo offline-first).

## Escenario principal (Main Success Scenario)
1. Diego está en **Pantalla 9 — Vista lote**.
2. Toca **"Registrar actividad"** → navega a `Routes.activityNew(<plotId>)` (**Pantalla 10 — Registrar actividad**).
3. Diligencia:
   - **Tipo** (dropdown obligatorio): `sowing` (siembra), `fertilization` (fertilización), `irrigation` (riego), `pest_control` (control de plagas), `harvest` (cosecha), `other` (otro).
   - **Fecha de ocurrencia** (`occurredAt`, `AppDateField`, default hoy).
   - **Descripción / notas** (opcional, ≤2000 chars).
   - **Foto** (opcional, máx 3 fotos según spec § A7 — validar implementación; el modelo solo guarda `photoUrl`).
4. Toca **"Guardar"** → mobile dispara `POST /v1/activities` con `{ plotId, type, occurredAt, description?, photoUrl? }`.
5. Backend valida (Zod), inserta fila en `activities`. Responde 201 con `Activity`.
6. Mobile vuelve a Pantalla 9; la nueva actividad aparece en el tope del timeline (DESC).
7. Snackbar: "Actividad guardada".

## Flujos alternos
- **A. Tipo inválido** o **`occurredAt` ausente** → `400 ValidationError`.
- **B. Lote ajeno** → `403 ForbiddenError` (el backend valida ownership del `plotId`).
- **C. Sin conexión** → la actividad queda en WatermelonDB local con `_status='created'` y aparece en el timeline igual. Sync al reconectar (CU-23). Foto local se guarda como URI local hasta el upload.
- **D. Foto >5 MB** (límite de UX) → snackbar "La foto es muy grande, comprime o usa una más pequeña". (La compresión local es regla UX §4 de espec-pantallas.)

## Postcondition
- Fila nueva en `activities` con `plot_id`, `type`, `occurred_at`, etc.
- UI rinde la actividad en el timeline.
- Verificable: `SELECT id, type, occurred_at FROM activities WHERE plot_id = '<plotId>' ORDER BY occurred_at DESC LIMIT 1;`. Ver [`010_create_activities.sql`](../../../../agritrace-backend/src/db/migrations/010_create_activities.sql).

## Acceptance criteria (Given/When/Then)
- **Given** Diego está en Pantalla 10 con tipo `harvest` y fecha hoy, **When** guarda con conexión, **Then** la actividad aparece en el timeline en ≤2 s.
- **Given** Diego intenta registrar actividad en lote ajeno (URL manipulada), **When** envía `POST`, **Then** backend responde 403.
- **Given** no hay conexión, **When** Diego guarda, **Then** la actividad queda en WatermelonDB local con `_status='created'` y aparece en el timeline visualmente; al reconectar se sincroniza.
- **Given** Diego adjunta una foto, **When** guarda, **Then** la actividad guarda `photoUrl` (local URI offline, remoto al sync) y la miniatura se muestra en el timeline.

## Estado de prueba
- **Estado:** ⚠️ pasa con notas — bug P1 ISO UTC corregido en v1.3.6, retest pendiente
- **Fecha de prueba:** 2026-05-20
- **Versión APK probada:** 1.3.5 (bug reproducido vía curl), fix shipping en v1.3.6
- **Notas de Diego (auto):**
  > Survey de código confirmó UI completa (`activity_create_screen`, `ActivityForm`, `activitiesProvider`). Form acepta los 6 tipos. **Reproducido vía curl:** payload con `occurredAt: "2026-05-20T12:00:00.000000"` (sin `Z`) devuelve 400 `{"error":"occurredAt: occurredAt must be an ISO 8601 datetime"}`. Mismo payload con `Z` retorna 201.
  > **Causa raíz:** `DateTime.now().toIso8601String()` en Dart retorna local-time sin sufijo `Z`. Backend Zod `.datetime()` strict.
  > **Fix v1.3.6** (commit `8c3a551`): `.toUtc().toIso8601String()` en `activity_service.dart` (create + update).
  > **Acción:** una vez `v1.3.6` esté instalado, registrar `sowing`, `fertilization`, `harvest` en `Lote A` (cacao) y `Lote B` (caña, ver [[CU-10]]). Cambiar estado a ✅ pasa si los 3 tipos se persisten y aparecen en [[CU-15]] timeline.
  > **Retest emulador 2026-05-20:** bloqueado por el bug de auth refresh detectado en [[CU-11]] (P3) — el `_AuthInterceptor` no completa el refresh al navegar de dashboard → finca-detail, deja la pantalla en "Credenciales incorrectas". El fix ISO UTC quedó **verificado a nivel de servicio vía curl + 200 tests** (`flutter test`), por lo que la causa raíz original está cerrada. Retest E2E queda pendiente al resolver el bug de refresh.

## Bugs históricos relevantes
- Ninguno documentado específico al form de actividad en CHANGELOG.
