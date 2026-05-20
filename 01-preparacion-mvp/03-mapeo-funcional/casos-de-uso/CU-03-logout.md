# CU-03 — Logout (revoca refresh)

| Campo | Valor |
|---|---|
| **ID** | CU-03 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego toca el botón **"Cerrar sesión"** en el dashboard (menú/AppBar). |
| **Endpoints invocados** | `authLogout` (`POST /v1/auth/logout`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 5 (Dashboard con fincas) o 4 (vacío) → Pantalla 1 (Bienvenida). Rutas: `Routes.dashboard` → `Routes.welcome`. |
| **RFs cubiertos** | RNF-06 (revocación de tokens), RNF-04 (almacenamiento seguro). |

## Preconditions
- Diego está autenticado (tokens en `FlutterSecureStorage`).
- Hay conexión a internet (la revocación viaja al servidor).

## Escenario principal (Main Success Scenario)
1. Diego está en **Pantalla 5 — Dashboard**.
2. Abre el menú (icono perfil / AppBar) y toca **"Cerrar sesión"**.
3. App muestra confirmación opcional ("¿Cerrar sesión?") y toca **"Confirmar"**.
4. Mobile dispara `POST /v1/auth/logout` con `{ refreshToken }`.
5. Backend agrega el `refreshToken` al `Set` en memoria de tokens revocados (ver `auth.service.ts`) y responde `{ success: true, data: { revoked: true } }`.
6. Mobile **borra los tokens** de `FlutterSecureStorage` (`access_token` + `refresh_token`).
7. App navega a `Routes.welcome` (Pantalla 1).

## Flujos alternos
- **A. Sin conexión al momento de logout** → la app igualmente debe borrar los tokens locales y navegar a Bienvenida (logout client-side). El refresh sigue válido server-side hasta su expiración (limitación MVP — Redis pendiente). Anotar en notas si la app no lo hace.
- **B. Refresh token ya revocado/expirado** → backend responde 401 → la app igualmente borra tokens locales y navega.
- **C. Cancelar confirmación** → no se ejecuta nada; Diego permanece en Dashboard.

## Postcondition
- `FlutterSecureStorage` sin `access_token` ni `refresh_token`.
- Backend tiene el refresh token en `revoked_tokens` (en memoria; resetea con restart).
- UI muestra Pantalla 1 (Bienvenida).
- Entrada en `audit_logs` (`action='auth.logout'`).

## Acceptance criteria (Given/When/Then)
- **Given** Diego está autenticado, **When** confirma logout, **Then** la app navega a Bienvenida en ≤2 s y los tokens locales están borrados.
- **Given** logout completó, **When** Diego intenta usar el `refreshToken` revocado (test manual con curl), **Then** backend responde 401.
- **Given** no hay conexión, **When** Diego cierra sesión, **Then** los tokens locales se borran y la app va a Bienvenida (con warning opcional).

## Estado de prueba
- **Estado:** ✅ pasa
- **Fecha de prueba:** 2026-05-20
- **Versión APK probada:** 1.3.3 (release APK)
- **Entorno:** emulador Android 14, Pixel 7 Pro AVD, arm64-v8a; backend v0.4.1. Tras CU-02 con sesión activa.
- **Notas de Diego (auto):**
  > Dashboard → tap ícono "Cerrar sesión" (top-right de la AppBar) → navegó a Pantalla 1 (Welcome) inmediatamente.
  > No se observó diálogo de confirmación intermedio — logout directo. Si se desea confirmación, pendiente UX call (no bloquea MVP).
  > Tokens borrados de `FlutterSecureStorage` (validado indirectamente: tras logout, el router redirigió a Welcome, confirmando estado `AuthUnauthenticated`).

## Bugs históricos relevantes
- Ninguno documentado para este flujo en CHANGELOG.
