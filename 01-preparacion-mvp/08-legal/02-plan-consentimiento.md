# Plan — Pantalla de Consentimiento + Captura Backend

Plan de implementación para registrar consentimiento explícito al
tratamiento de datos (Ley 1581 art. 9 / Decreto 1377 art. 5). **No
implementado aún** — este documento es el plan; el endpoint ARCO
(export/erase) ya existe en backend (v0.1.5).

## 1. Pantalla de registro (Flutter — `agritrace-mobile`)

`lib/screens/auth/register_screen.dart`:

- Añadir un **checkbox obligatorio** antes del botón "Crear cuenta":
  > ☐ He leído y acepto la [Política de Privacidad](enlace) y el
  > tratamiento de mis datos conforme a la Ley 1581.
- El botón "Crear cuenta" queda **deshabilitado** hasta marcar el
  checkbox (consentimiento inequívoco, no pre-marcado).
- El enlace abre la política (ver §3 hosting) en `url_launcher` /
  in-app webview.
- Estado del checkbox se envía al backend en el registro.

## 2. Captura en backend (`agritrace-backend`)

Evidencia auditable del consentimiento (quién, cuándo, qué versión):

- **Migración `007_add_privacy_consent.sql`**: añadir a `users`
  - `privacy_consent_at TIMESTAMPTZ`
  - `privacy_consent_version VARCHAR(20)`
- **`auth.validations.ts`** (`registerSchema`): nuevo campo requerido
  `privacyConsent: z.literal(true)` + `privacyConsentVersion: string`.
- **`auth.service.ts` `register()`**: persistir `privacy_consent_at =
  NOW()` y la versión recibida en el `INSERT INTO users`.
- Rechazo `400` si `privacyConsent` no es `true` (defensa en
  profundidad, igual que el guard de rol).
- **Export** (`GET /v1/users/me/export`): incluir
  `privacyConsentAt`/`privacyConsentVersion` en el dataset.

EP/endpoint: no requiere endpoint nuevo — se acopla al
`POST /v1/auth/register` existente. El derecho de revocación se
satisface con el `DELETE /v1/users/me` ya implementado (v0.1.5).

## 3. Hosting de la política

Opciones (MVP — elegir una):

| Opción | Esfuerzo | Nota |
|--------|----------|------|
| **A. Página en demo Vercel** `agritrace-demo.vercel.app/privacidad` | Bajo | Render del markdown; URL estable, recomendado |
| B. Endpoint backend `GET /v1/legal/privacy` (texto/markdown) | Medio | Disponible offline-cerca; superficie extra |
| C. Enlace al doc en GitHub | Mínimo | Repo privado→público requerido; menos "producto" |

Recomendado: **A** (estable, sin tocar backend; el doc fuente vive en
`08-legal/01-politica-privacidad.md`).

## 4. Orden de implementación

1. Migración 007 + validación + persistencia consentimiento (backend,
   release v0.1.6 → `deploy.sh` ya migra).
2. Publicar política (opción A) — ruta `/privacidad` en demo.
3. Checkbox + enlace en `register_screen.dart` (mobile).
4. Verificar: registro sin consentimiento → 400; con consentimiento →
   `privacy_consent_at` poblado; export lo incluye.

## 5. Pendientes legales relacionados (fuera de este plan)

- Marcar `[x]` en `06-infraestructura/01-decisiones-infra.md §7.2`
  ("Redactar política de privacidad", "Política de privacidad
  publicada y enlazada desde la app") cuando 1–3 estén hechos.
- Procedimiento de respuesta a solicitudes Habeas Data por el canal
  de contacto (10/15 días hábiles) — operativo, documentar en runbook.
