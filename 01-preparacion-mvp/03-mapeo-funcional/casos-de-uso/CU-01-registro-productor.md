# CU-01 — Registro de productor con consentimiento Ley 1581

| Campo | Valor |
|---|---|
| **ID** | CU-01 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego toca el TextButton **"¿No tienes cuenta? Regístrate"** en la Pantalla 1 (Bienvenida). |
| **Endpoints invocados** | `authRegister` (`POST /v1/auth/register`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 1 (Bienvenida), Pantalla 2 (Registro), Pantalla 4 (Dashboard vacío). Ver [`02-especificaciones-pantallas`](../../04-diseno-ui-ux/02-especificaciones-pantallas/01-especificaciones-pantallas.md) §3.1–3.2. Rutas: `Routes.welcome`, `Routes.register`, `Routes.dashboard`. |
| **RFs cubiertos** | RF-01 (perfil productor), RNF-05 (Ley 1581), RNF-06 (TLS+JWT). Ver [`requerimientos-funcionales`](../../02-requerimientos-funcionales/01-requerimientos-funcionales.md). |

## Preconditions
- APK v1.3.3 instalado en el Pixel; usuario **no autenticado** (StorageService sin `access_token`).
- Backend prod (`api.agritrace.co/v1`) responde 200 a `/v1/health`.
- Diego tiene un email nuevo no usado (`diego.test+YYYYMMDD@agritrace.co`).
- Hay conexión a internet (red activa, sin avión).

## Escenario principal (Main Success Scenario)
1. Diego abre la app → ve **Pantalla 1 — Bienvenida** con logo, el `AppButton` primario **"Iniciar sesión"** y un `TextButton` subrayado **"¿No tienes cuenta? Regístrate"** debajo.
2. Diego toca el TextButton **"¿No tienes cuenta? Regístrate"** → app navega a `Routes.register` (**Pantalla 2 — Registro**).
3. Diligencia los 4 campos en el orden en que aparecen en la pantalla: nombre completo (texto se capitaliza por palabra — ver bug histórico abajo), teléfono, email, contraseña (≥8 chars, con minúscula + mayúscula + dígito).
4. Marca la **casilla de consentimiento Ley 1581** ("Acepto la [Política de Privacidad] y el tratamiento de mis datos (Ley 1581)"). El botón **"Registrarse"** se habilita.
5. Toca **"Registrarse"** → mobile dispara `POST /v1/auth/register` con `{ email, password, fullName, phone, privacyConsent: true, privacyConsentVersion: "1.0" }` — **sin `role`**, el server lo asigna por defecto (`'producer'`) por seguridad. Enviar un `role` elegido por el cliente sería un intento de bypass de autorización; por eso `auth_service.dart` lo omite explícitamente y el schema Zod del backend usa `producer` como default.
6. Backend valida (Zod), hashea password (bcrypt ≥10 rounds), crea fila en `users` + `producers` + registra el consentimiento, emite `accessToken` (15 min) + `refreshToken` (7 d).
7. Mobile guarda tokens en `FlutterSecureStorage`, navega a `Routes.dashboard` → **Pantalla 4 — Dashboard vacío** ("Aún no has registrado una finca").

## Flujos alternos
- **A. Email duplicado** → backend responde `409 ConflictError` → `AppErrorBanner` inline arriba del botón "Registrarse" con el mensaje "Ese email ya está registrado". Diego permanece en Pantalla 2 con los campos completos.
- **B. Password débil** (sin mayúscula o <8 chars) → Zod falla → `400 ValidationError` → mensaje inline en el campo Contraseña: "Debe incluir minúscula, mayúscula y dígito".
- **C. Sin consentimiento** → checkbox vacío → el botón "Registrarse" queda **deshabilitado** (validación client-side); no se invoca el endpoint.
- **D. Rate limit (>5 intentos en 15 min)** → backend responde `429 RateLimited` → `AppErrorBanner` inline arriba del botón "Registrarse" con el mensaje "Muchos intentos, intenta de nuevo en unos minutos".
- **E. Sin conexión** → `AppErrorBanner` inline arriba del botón "Registrarse" con el mensaje "Sin conexión, verifica tu internet" (el registro **no** se encola offline; requiere red).

## Postcondition
- Fila nueva en `users` con `role=producer`, `is_active=true`, `password_hash` bcrypt, `privacy_consent_at` timestamp.
- Fila nueva en `producers` con FK al `users.id`.
- Entrada en `audit_logs` (`action='auth.register'`).
- Tokens persistidos en `FlutterSecureStorage` (`access_token`, `refresh_token`).
- UI muestra Pantalla 4 (Dashboard vacío).
- Verificable: `SELECT id, email, role, privacy_consent_at FROM users WHERE email = 'diego.test+YYYYMMDD@agritrace.co';` debe retornar 1 fila. Ver [`007_add_privacy_consent.sql`](../../../../agritrace-backend/src/db/migrations/007_add_privacy_consent.sql).

## Acceptance criteria (Given/When/Then)
- **Given** Diego está en Pantalla 1 y no tiene cuenta, **When** completa los 4 campos válidos + marca consentimiento + toca "Registrarse", **Then** la app navega a Pantalla 4 en ≤2 s y los tokens quedan guardados.
- **Given** el email ya está en `users`, **When** se intenta registrar, **Then** el backend responde 409 y la UI muestra un `AppErrorBanner` inline ("Ese email ya está registrado") sin perder los datos del formulario.
- **Given** el checkbox de consentimiento **no** está marcado, **When** Diego intenta tocar "Registrarse", **Then** el botón está deshabilitado y no hay request HTTP.
- **Given** el registro fue exitoso, **When** se inspecciona la DB, **Then** existe `users.privacy_consent_at IS NOT NULL` y `users.role = 'producer'`.

## Estado de prueba
- **Estado:** ✅ pasa
- **Fecha de prueba:** 2026-05-20
- **Versión APK probada:** 1.3.3 (release APK del GitHub Release)
- **Entorno:** emulador Android 14, Pixel 7 Pro AVD, arm64-v8a; backend prod v0.4.1 en `api.agritrace.co`. Ejecutado por Claude vía `adb` (sin Pixel físico).
- **Notas de Diego (auto):**
  > Welcome renderiza con `AppButton` "Iniciar sesión" + `TextButton` "¿No tienes cuenta? Regístrate" — coincide con el CU actualizado (no es el layout simétrico inicial).
  > Registro renderiza con orden Nombre→Teléfono→Email→Contraseña — coincide con CU actualizado.
  > **`TextCapitalization.words` funciona en el IME del emulador:** "juan gomez" se autocapitaliza a "Juan Gomez" al escribir.
  > **Toggle ojo de password** muestra `visibility_off_outlined` (ícono tachado) cuando hidden — confirma fix v1.3.3 vigente en runtime.
  > Botón "Registrarse" se mantuvo disabled hasta marcar consentimiento — gating de Ley 1581 OK.
  > Submit con datos válidos → `POST /v1/auth/register` 201 → tokens guardados → navegó a Dashboard (`AgriTrace` AppBar + canvas vacío + FAB "+"). Tiempo total: < 1 s.
  > Cleanup vía `DELETE /v1/users/me` 200 → `users` row borrado, `deletion_requests` con status `completed` (Ley 1581 ARCO).

## Bug nuevo descubierto durante esta prueba
- **P2 — `google_fonts` Inter no se carga en runtime.** `lib/main.dart:11` setea
  `GoogleFonts.config.allowRuntimeFetching = false` (correcto offline-first) pero los TTF de Inter
  **no están bundleados** en `pubspec.yaml` como assets. Cada render que pida Inter logea una
  `Unhandled Exception: GoogleFonts.config.allowRuntimeFetching is false but font Inter-SemiBold
  was not found`. Cae silenciosamente a la fuente del sistema. Funcional pero ruidoso + perf hit.
  No bloquea Sprint 5. Programar hotfix v1.3.5 (declarar Inter TTFs como assets).

## Bugs históricos relevantes
- **v1.3.1** — crash al abrir Android por `MainActivity` en paquete inexistente (`com.example.agritrace_mobile`). Si el flujo de registro **no abre la app**, validar que el bug no regresó. Ver CHANGELOG mobile entrada `2026-05-19 — fix: crash al abrir + nombre de la app`.
- **v1.3.2** — permiso `INTERNET` faltaba en `main/AndroidManifest.xml`; el registro mostraba "Sin conexión" aún con red. Ver CHANGELOG mobile entrada `2026-05-19 — fix: sin red en APK release`.
- **v1.3.3** — campo "Nombre completo" no capitalizaba la primera letra de cada palabra. Confirmar que ya capitaliza durante el flujo paso 3. Ver CHANGELOG mobile entrada `2026-05-19 — fix: UX inputs auth`.
- **2026-05-20** — `error_parser.dart` mapea ahora 409 → "Ese email ya está registrado", 429 → "Muchos intentos, intenta de nuevo en unos minutos", y sin respuesta de red → "Sin conexión, verifica tu internet". Estos son los mensajes exactos que aparecen en el `AppErrorBanner` durante los flujos alternos A, D y E de este CU. Ver CHANGELOG mobile entrada `2026-05-20 — fix(ux): map 409/429 to specific messages`.
