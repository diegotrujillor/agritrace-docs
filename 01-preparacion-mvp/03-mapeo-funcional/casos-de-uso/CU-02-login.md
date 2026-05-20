# CU-02 — Login email + contraseña

| Campo | Valor |
|---|---|
| **ID** | CU-02 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego toca el botón **"Ingresar"** en la Pantalla 1 (Bienvenida). |
| **Endpoints invocados** | `authLogin` (`POST /v1/auth/login`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 1 (Bienvenida), Pantalla 3 (Login), Pantalla 4 (Dashboard vacío) o Pantalla 5 (Dashboard con fincas). Rutas: `Routes.welcome`, `Routes.login`, `Routes.dashboard`. |
| **RFs cubiertos** | RF-01, RNF-06 (TLS+JWT). |

## Preconditions
- APK v1.3.3 instalado; usuario **no autenticado**.
- Existe en backend prod una cuenta activa para Diego (creada en CU-01).
- Backend responde 200 a `/v1/health`.
- Hay conexión a internet.

## Escenario principal (Main Success Scenario)
1. Diego abre la app → **Pantalla 1 — Bienvenida**.
2. Toca **"Ingresar"** → navega a `Routes.login` (**Pantalla 3 — Login**).
3. Ingresa email + contraseña. El ícono del ojo en el campo Contraseña muestra el estado correcto (oculto = ojo tachado, ver bug histórico).
4. Toca **"Ingresar"** → mobile dispara `POST /v1/auth/login`.
5. Backend valida credenciales contra `users.password_hash` (bcrypt), emite `accessToken` + `refreshToken`.
6. Mobile guarda tokens en `FlutterSecureStorage` y navega a `Routes.dashboard`.
7. Dashboard se rinde: **Pantalla 4** (si no hay fincas) o **Pantalla 5** (con tarjetas de fincas).

## Flujos alternos
- **A. Credenciales inválidas** → `401 UnauthorizedError` → snackbar "Email o contraseña incorrectos". Campo de contraseña se limpia, email se conserva.
- **B. Email no registrado** → backend responde 401 (mismo mensaje genérico, **no** revela si existe) — buen comportamiento de seguridad.
- **C. Rate limit** → `429 RateLimited` después de 5 intentos en 15 min → snackbar correspondiente.
- **D. Sin conexión** → snackbar "Sin conexión, verifica tu internet".
- **E. Token aún válido en SecureStorage** → al abrir la app, el `routerProvider` redirige directo a `Routes.dashboard` sin pasar por Pantalla 3.

## Postcondition
- Tokens nuevos persistidos en `FlutterSecureStorage`.
- Entrada en `audit_logs` (`action='auth.login'`).
- UI en Pantalla 4 o 5 según haya fincas.
- Verificable en DB: `SELECT last_login_at FROM users WHERE email = ...;` debería actualizarse (si el backend lo registra).

## Acceptance criteria (Given/When/Then)
- **Given** Diego tiene cuenta activa, **When** ingresa credenciales correctas y toca "Ingresar", **Then** llega a Dashboard en ≤2 s con tokens guardados.
- **Given** la contraseña es incorrecta, **When** se intenta login, **Then** el backend responde 401 y la UI muestra mensaje **genérico** (sin distinguir email/password).
- **Given** Diego está autenticado y cierra la app, **When** la vuelve a abrir, **Then** entra directo a Dashboard sin re-loguearse (auto-refresh del access token vía `_AuthInterceptor`).

## Estado de prueba
- **Estado:** ✅ pasa
- **Fecha de prueba:** 2026-05-20
- **Versión APK probada:** 1.3.3 (release APK)
- **Entorno:** emulador Android 14, Pixel 7 Pro AVD, arm64-v8a; backend v0.4.1. Ejecutado por Claude vía `adb`.
- **Notas de Diego (auto):**
  > Welcome → tap "Iniciar sesión" → Login screen renderiza (Email + Contraseña + botón Iniciar sesión + link "¿No tienes cuenta? Regístrate").
  > Email + password aceptados; submit → `POST /v1/auth/login` 200 → tokens guardados → navegó a Dashboard (Pantalla 4 - empty state "No tienes fincas aún" + CTA "Registrar finca").
  > AppBar muestra acciones: bell (alertas) + logout (cerrar sesión). Tiempo total < 1 s.

## Bugs históricos relevantes
- **v1.3.2** — permiso `INTERNET` faltaba: login mostraba "Sin conexión" con red activa. Confirmar que **no** regresa.
- **v1.3.3** — ícono del ojo en campo Contraseña invertido. Confirmar paso 3: oculto = tachado.
