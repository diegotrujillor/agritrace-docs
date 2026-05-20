# CU-01 — Registro de productor con consentimiento Ley 1581

| Campo | Valor |
|---|---|
| **ID** | CU-01 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego toca el botón **"Crear cuenta"** en la Pantalla 1 (Bienvenida). |
| **Endpoints invocados** | `authRegister` (`POST /v1/auth/register`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 1 (Bienvenida), Pantalla 2 (Registro), Pantalla 4 (Dashboard vacío). Ver [`02-especificaciones-pantallas`](../../04-diseno-ui-ux/02-especificaciones-pantallas/01-especificaciones-pantallas.md) §3.1–3.2. Rutas: `Routes.welcome`, `Routes.register`, `Routes.dashboard`. |
| **RFs cubiertos** | RF-01 (perfil productor), RNF-05 (Ley 1581), RNF-06 (TLS+JWT). Ver [`requerimientos-funcionales`](../../02-requerimientos-funcionales/01-requerimientos-funcionales.md). |

## Preconditions
- APK v1.3.3 instalado en el Pixel; usuario **no autenticado** (StorageService sin `access_token`).
- Backend prod (`api.agritrace.co/v1`) responde 200 a `/v1/health`.
- Diego tiene un email nuevo no usado (`diego.test+YYYYMMDD@agritrace.co`).
- Hay conexión a internet (red activa, sin avión).

## Escenario principal (Main Success Scenario)
1. Diego abre la app → ve **Pantalla 1 — Bienvenida** con logo y botones "Ingresar" / "Crear cuenta".
2. Toca **"Crear cuenta"** → app navega a `Routes.register` (**Pantalla 2 — Registro**).
3. Diligencia los 4 campos: nombre completo (texto se capitaliza por palabra — ver bug histórico abajo), email, teléfono, contraseña (≥8 chars, con minúscula + mayúscula + dígito).
4. Marca la **casilla de consentimiento Ley 1581** ("Acepto la [política de privacidad]"). El botón "Crear cuenta" se habilita.
5. Toca **"Crear cuenta"** → mobile dispara `POST /v1/auth/register` con `privacyConsent: true`, `privacyConsentVersion: "1.0"`, `role: producer`.
6. Backend valida (Zod), hashea password (bcrypt ≥10 rounds), crea fila en `users` + `producers` + registra el consentimiento, emite `accessToken` (15 min) + `refreshToken` (7 d).
7. Mobile guarda tokens en `FlutterSecureStorage`, navega a `Routes.dashboard` → **Pantalla 4 — Dashboard vacío** ("Aún no has registrado una finca").

## Flujos alternos
- **A. Email duplicado** → backend responde `409 ConflictError` → snackbar "Ese email ya está registrado". Diego permanece en Pantalla 2 con los campos completos.
- **B. Password débil** (sin mayúscula o <8 chars) → Zod falla → `400 ValidationError` → mensaje inline en el campo Contraseña: "Debe incluir minúscula, mayúscula y dígito".
- **C. Sin consentimiento** → checkbox vacío → el botón "Crear cuenta" queda **deshabilitado** (validación client-side); no se invoca el endpoint.
- **D. Rate limit (>5 intentos en 15 min)** → backend responde `429 RateLimited` → snackbar "Muchos intentos, intenta de nuevo en unos minutos".
- **E. Sin conexión** → snackbar "Sin conexión, verifica tu internet" (el registro **no** se encola offline; requiere red).

## Postcondition
- Fila nueva en `users` con `role=producer`, `is_active=true`, `password_hash` bcrypt, `privacy_consent_at` timestamp.
- Fila nueva en `producers` con FK al `users.id`.
- Entrada en `audit_logs` (`action='auth.register'`).
- Tokens persistidos en `FlutterSecureStorage` (`access_token`, `refresh_token`).
- UI muestra Pantalla 4 (Dashboard vacío).
- Verificable: `SELECT id, email, role, privacy_consent_at FROM users WHERE email = 'diego.test+YYYYMMDD@agritrace.co';` debe retornar 1 fila. Ver [`007_add_privacy_consent.sql`](../../../../agritrace-backend/src/db/migrations/007_add_privacy_consent.sql).

## Acceptance criteria (Given/When/Then)
- **Given** Diego está en Pantalla 1 y no tiene cuenta, **When** completa los 4 campos válidos + marca consentimiento + toca "Crear cuenta", **Then** la app navega a Pantalla 4 en ≤2 s y los tokens quedan guardados.
- **Given** el email ya está en `users`, **When** se intenta registrar, **Then** el backend responde 409 y la UI muestra mensaje sin perder los datos del formulario.
- **Given** el checkbox de consentimiento **no** está marcado, **When** Diego intenta tocar "Crear cuenta", **Then** el botón está deshabilitado y no hay request HTTP.
- **Given** el registro fue exitoso, **When** se inspecciona la DB, **Then** existe `users.privacy_consent_at IS NOT NULL` y `users.role = 'producer'`.

## Estado de prueba
- **Estado:** 🟡 pendiente
- **Fecha de prueba:**
- **Versión APK probada:**
- **Notas de Diego:**
  > <espacio para anotar lo observado>

## Bugs históricos relevantes
- **v1.3.1** — crash al abrir Android por `MainActivity` en paquete inexistente (`com.example.agritrace_mobile`). Si el flujo de registro **no abre la app**, validar que el bug no regresó. Ver CHANGELOG mobile entrada `2026-05-19 — fix: crash al abrir + nombre de la app`.
- **v1.3.2** — permiso `INTERNET` faltaba en `main/AndroidManifest.xml`; el registro mostraba "Sin conexión" aún con red. Ver CHANGELOG mobile entrada `2026-05-19 — fix: sin red en APK release`.
- **v1.3.3** — campo "Nombre completo" no capitalizaba la primera letra de cada palabra. Confirmar que ya capitaliza durante el flujo paso 3. Ver CHANGELOG mobile entrada `2026-05-19 — fix: UX inputs auth`.
