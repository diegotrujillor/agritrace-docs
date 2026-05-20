# CU-05 — Exportar datos personales (ARCO derecho de acceso)

| Campo | Valor |
|---|---|
| **ID** | CU-05 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego toca **"Exportar mis datos"** en la pantalla de perfil/ajustes. |
| **Endpoints invocados** | `usersExportMe` (`GET /v1/users/me/export`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 5 (Dashboard) → diálogo/Share-sheet con el JSON. |
| **RFs cubiertos** | RNF-05 (Ley 1581 — derecho de acceso). |

## Preconditions
- Diego está autenticado.
- Hay conexión a internet.
- Diego tiene al menos 1 finca + 1 lote + 1 actividad para que el bundle tenga contenido representativo.

## Escenario principal (Main Success Scenario)
1. Diego está en **Pantalla 5 — Dashboard**.
2. Abre menú de perfil → toca **"Exportar mis datos"**.
3. Mobile dispara `GET /v1/users/me/export`.
4. Backend agrega todas las filas del usuario (`users`, `producers`, `farms`, `plots`, `activities`, `alerts`) en un objeto JSON. Responde `{ success: true, data: { user, producer, farms, plots, activities, alerts } }`.
5. Mobile guarda el JSON en almacenamiento local temporal y abre el **Share-sheet** Android (Intent `ACTION_SEND`) para compartir vía Drive, email, WhatsApp, etc.
6. Diego elige destino (ej. su email) → confirma.
7. Snackbar: "Datos exportados".

## Flujos alternos
- **A. Sin conexión** → snackbar "Sin conexión, verifica tu internet"; el export **no** se encola offline.
- **B. Bundle vacío (usuario sin datos)** → backend igual responde 200 con `farms: []`, etc. Mobile permite descargar el JSON aunque solo contenga `user` + `producer`.
- **C. Cancelar Share-sheet** → archivo temporal se descarta; no se persiste copia.

## Postcondition
- Archivo `agritrace-export-<userId>-<timestamp>.json` enviado al destino elegido.
- Entrada en `audit_logs` (`action='users.export'`) — Ley 1581 exige loggear accesos.
- No hay cambio en filas de datos del usuario (es una operación de lectura).

## Acceptance criteria (Given/When/Then)
- **Given** Diego está autenticado con datos, **When** toca "Exportar mis datos", **Then** recibe un archivo JSON con todas sus fincas/lotes/actividades/alertas en ≤5 s.
- **Given** el archivo se generó, **When** Diego lo abre, **Then** el JSON valida contra el envelope `{ success: true, data: {...} }` y contiene `user.email` correcto.
- **Given** el export se completó, **When** se consulta `audit_logs`, **Then** existe una entrada con `action='users.export'` y `user_id` correcto.

## Estado de prueba
- **Estado:** ⚠️ pasa con notas — **falta UI mobile**
- **Fecha de prueba:** 2026-05-20
- **Versión APK probada:** 1.3.3
- **Entorno:** emulador AVD + backend v0.4.1.
- **Notas de Diego (auto):**
  > **Backend:** endpoint `GET /v1/users/me/export` existe y está documentado en `openapi.yaml` (operationId `usersExportMe`). Devuelve bundle JSON con todas las filas asociadas al usuario autenticado. No ejercitado en runtime acá (cliente lo necesita).
  > **Mobile:** **NO existe UI para exportar datos desde la app** (grep en `lib/` por "exportar.*datos" / "me/export" / "exportMe" no encontró nada — sólo el export-PDF de plots).
  > **Workaround MVP:** el productor solicita su bundle escribiendo a `diegotrujillor@gmail.com` (canal documentado en política de privacidad). Diego ejecuta `curl -H "Authorization: Bearer …" https://api.agritrace.co/v1/users/me/export > diego_data.json` manualmente.
  > **Bug:** P2 — añadir acción "Exportar mis datos" en perfil/dashboard antes de Production. No bloquea Sprint 5 (compliance Ley 1581 satisfecho por canal email manual).

## Bugs históricos relevantes
- Ninguno documentado para este flujo en CHANGELOG.
