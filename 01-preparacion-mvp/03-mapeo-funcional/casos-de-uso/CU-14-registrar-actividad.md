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
- **Estado:** 🟡 pendiente
- **Fecha de prueba:**
- **Versión APK probada:**
- **Notas de Diego:**
  > <espacio para anotar lo observado> — probar al menos 3 de los 6 tipos en esta sesión.

## Bugs históricos relevantes
- Ninguno documentado específico al form de actividad en CHANGELOG.
