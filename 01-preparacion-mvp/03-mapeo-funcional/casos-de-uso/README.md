# Casos de uso — MVP AgriTrace (Sprint 5 pre-piloto)

**Versión:** 1.0 (Mayo 2026)
**Owner:** Diego Trujillo
**Estado:** 🟡 pre-piloto — Diego ejecuta el smoke-test antes de reclutar testers.

---

## 1. Propósito

Esta carpeta contiene los **25 casos de uso (CU)** del MVP AgriTrace, derivados de los requerimientos funcionales y de las 10 pantallas del Flow A (Productor) en [`02-especificaciones-pantallas`](../../04-diseno-ui-ux/02-especificaciones-pantallas/01-especificaciones-pantallas.md).

Cada CU cumple tres funciones simultáneas:

1. **Criterio de aceptación** — el comportamiento esperado del MVP, con Given/When/Then.
2. **Caso de prueba manual ejecutable** — Diego lo corre en el Pixel 7 Pro (APK v1.3.3, backend prod v0.3.0) **antes** de invitar los 5 productores del piloto (ver runbook [`01-sprint-5-pilot-runbook.md`](../../07-gestion-de-proyectos/01-sprint-5-pilot-runbook.md)).
3. **Spec ejecutable para futuros devs** — describe el flujo punta-a-punta con endpoints (`operationId` de [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml)), pantallas y RFs.

> Los CU **no reemplazan** los tests automatizados (cobertura ≥80% en mobile y backend); cubren la pieza que solo se valida con humano + dispositivo real.

---

## 2. Cómo probar (5 pasos)

1. **Instalar APK v1.3.3** firmado en el Pixel 7 Pro (descargar del [GitHub Release `v1.3.3`](https://github.com/diegotrujillor/agritrace-mobile/releases) o build local `flutter build apk --release`).
2. **Verificar backend prod** vivo: `curl https://api.agritrace.co/v1/health` debe responder `{"success":true,"data":{"status":"ok","commit":"<sha>"...}}`.
3. **Abrir el CU** correspondiente (ej. `CU-02-login.md`), seguir el **Escenario principal** paso a paso en el Pixel.
4. **Marcar el resultado** en la sección "Estado de prueba" del archivo CU: cambiar `🟡 pendiente` por `✅ pasa` / `⚠️ pasa con notas` / `❌ falla`, anotar fecha y observaciones.
5. **Actualizar la fila** correspondiente en la tabla maestra de este README (estado + fecha + notas cortas). Si hay bug bloqueante, abrir issue con el template `field-test-bug.yml`.

> Tiempo objetivo: ≤5 min por CU. Sesión completa de smoke-test (25 CU): ~2 h.

---

## 3. Leyenda de estado

| Símbolo | Significado |
|---|---|
| 🟡 | **pendiente** — no se ha probado todavía. |
| ✅ | **pasa** — escenario principal y criterios de aceptación cumplidos. |
| ⚠️ | **pasa con notas** — cumple criterios pero hay fricción UX o un flujo alterno fallando (no bloqueante). |
| ❌ | **falla** — algún criterio de aceptación no se cumple. Issue obligatorio. |

---

## 4. Tabla maestra

| CU-ID | Título | Prioridad MVP | Estado | Fecha de prueba | Notas cortas |
|---|---|---|---|---|---|
| [CU-01](CU-01-registro-productor.md) | Registro de productor con consentimiento Ley 1581 | MUST | ✅ pasa | 2026-05-20 | Emulador AVD Android 14 + v1.3.3; descubrió P2 google_fonts Inter no bundled |
| [CU-02](CU-02-login.md) | Login email + contraseña | MUST | ✅ pasa | 2026-05-20 | Emulador AVD; v1.3.3; navegó a Dashboard < 1 s |
| [CU-03](CU-03-logout.md) | Logout (revoca refresh) | MUST | ✅ pasa | 2026-05-20 | Emulador AVD; sin diálogo de confirmación (UX call opcional) |
| [CU-04](CU-04-solicitar-borrado-cuenta.md) | Solicitar borrado de cuenta (ARCO derecho al olvido) | MUST | ⚠️ pasa con notas | 2026-05-20 | Backend OK; **mobile UI ausente** — workaround vía email + curl. P2 |
| [CU-05](CU-05-exportar-datos-personales.md) | Exportar datos personales (ARCO derecho de acceso) | MUST | ⚠️ pasa con notas | 2026-05-20 | Backend OK; **mobile UI ausente** — workaround vía email + curl. P2 |
| [CU-06](CU-06-crear-finca.md) | Crear finca con cultivo + área + coordenadas opcionales | MUST | ❌ **FALLA — P1 BLOQUEADOR** | 2026-05-20 | Backend OK; mobile muestra error genérico tras crear fila en DB. **Bloquea Sprint 5.** Bug en parseo de respuesta o `_refresh()` |
| [CU-07](CU-07-ver-lista-fincas.md) | Ver lista de fincas en dashboard | MUST | 🟡 pendiente | | |
| [CU-08](CU-08-ver-detalle-editar-finca.md) | Ver detalle de finca + editar | MUST | 🟡 pendiente | | |
| [CU-09](CU-09-eliminar-finca.md) | Eliminar finca (cascada visible: los lotes desaparecen) | MUST | 🟡 pendiente | | |
| [CU-10](CU-10-crear-lote.md) | Crear lote dentro de una finca | MUST | 🟡 pendiente | | |
| [CU-11](CU-11-ver-detalle-lote-timeline.md) | Ver detalle de lote + timeline de actividades | MUST | 🟡 pendiente | | |
| [CU-12](CU-12-editar-lote-status.md) | Editar lote (cambio de status planning→growing→ready→harvested) | MUST | 🟡 pendiente | | |
| [CU-13](CU-13-eliminar-lote.md) | Eliminar lote (cascada: las actividades desaparecen) | MUST | 🟡 pendiente | | |
| [CU-14](CU-14-registrar-actividad.md) | Registrar actividad (los 6 tipos) | MUST | 🟡 pendiente | | |
| [CU-15](CU-15-ver-timeline-actividades.md) | Ver timeline ordenado por fecha | MUST | 🟡 pendiente | | |
| [CU-16](CU-16-editar-actividad.md) | Editar actividad (fecha, descripción, foto) | MUST | 🟡 pendiente | | |
| [CU-17](CU-17-eliminar-actividad.md) | Eliminar actividad | MUST | 🟡 pendiente | | |
| [CU-18](CU-18-crear-recordatorio-manual.md) | Crear recordatorio manual con scheduled_for | SHOULD | 🟡 pendiente | | |
| [CU-19](CU-19-chequear-clima-lote.md) | Chequear clima del lote → genera alerta weather si umbral cruzado | SHOULD | 🟡 pendiente | | |
| [CU-20](CU-20-listar-alertas-sync-badge.md) | Listar alertas + sync status badge | SHOULD | 🟡 pendiente | | |
| [CU-21](CU-21-descartar-eliminar-alerta.md) | Descartar/eliminar alerta | SHOULD | 🟡 pendiente | | |
| [CU-22](CU-22-trabajar-offline.md) | Trabajar offline sin pérdida (registros locales) | MUST | 🟡 pendiente | | |
| [CU-23](CU-23-reconectar-sincronizar.md) | Reconectar y sincronizar (push + pull) | MUST | 🟡 pendiente | | |
| [CU-24](CU-24-resolucion-conflicto-lww.md) | Resolución de conflicto LWW (dos clientes editan misma fila offline) | SHOULD | 🟡 pendiente | | |
| [CU-25](CU-25-exportar-pdf-trazabilidad.md) | Exportar PDF de trazabilidad por lote | MUST | 🟡 pendiente | | |

**Cobertura por prioridad:** 19 MUST · 6 SHOULD · 0 COULD.

---

## 5. Cross-referencias

- **Requerimientos funcionales:** [`02-requerimientos-funcionales/01-requerimientos-funcionales.md`](../../02-requerimientos-funcionales/01-requerimientos-funcionales.md) — los CU cubren RF-01 a RF-11 (MoSCoW MUST + SHOULD).
- **Pantallas (Flow A productor):** [`04-diseno-ui-ux/02-especificaciones-pantallas/01-especificaciones-pantallas.md`](../../04-diseno-ui-ux/02-especificaciones-pantallas/01-especificaciones-pantallas.md) — pantallas 1-10.
- **Endpoints (operationId):** [`agritrace-backend/docs/openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) — 30 endpoints en v0.3.0.
- **Envelope + error classes:** [`agritrace-backend/docs/API.md`](../../../../agritrace-backend/docs/API.md).
- **Rutas móviles:** [`agritrace-mobile/lib/navigation/route_names.dart`](../../../../agritrace-mobile/lib/navigation/route_names.dart).
- **Mapeo funcional (overview):** [`../01-mapeo-funcional.md`](../01-mapeo-funcional.md).
- **Scope MVP (fuente única):** [`../../09-scope-mvp.md`](../../09-scope-mvp.md).

---

## 6. Lo que NO está cubierto (deliberadamente)

- **QR público, marketplace, dashboard cooperativa/exportador, certificación digital** — diferidos a iteración futura ([`09-scope-mvp.md §4`](../../09-scope-mvp.md)).
- **Recuperar contraseña** — la pantalla 3 (Login) menciona el link pero el backend MVP no expone endpoint `/auth/reset`. CU no creado.
- **SMS/USSD fallback (RF-12)** — Should-have diferido; el backend ya tiene el seam `notification.service` con canal `log` por defecto pero no hay UX de productor que lo dispare. CU no creado.
- **Adjuntar certificados PDF (RF-13)** — Could-have, no implementado en pantallas v1.3.3.

---

## 7. Notas de ejecución para Diego

- **Datos de prueba:** crear usuario nuevo `diego.test+<fecha>@agritrace.co` en cada sesión para no contaminar. Al final de la sesión, ejecutar CU-04 (borrado de cuenta) para limpiar.
- **Conectividad:** algunos CU exigen toggling de avión + Wi-Fi. Tener un cronómetro a mano para CU-22 (offline).
- **Backend prod commit:** anotar el SHA devuelto por `/v1/health` la primera vez en la fila CU-01 (notas), para correlación con bugs.
- **Si un bug aparece, no parchear durante la sesión.** Abrir issue, marcar `❌ falla`, continuar con los siguientes CU. Sprint 5 inicia recién cuando todos los MUST estén ✅ o ⚠️.

---

Fin del README — preparado para Sprint 5 (Mayo 2026).
