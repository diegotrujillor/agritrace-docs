# Política de Privacidad — AgriTrace

**Versión 1.0 · Vigente desde: 2026-05-19**
*(Cumplimiento Ley 1581 de 2012 y Decreto 1377 de 2013 — Habeas Data, Colombia)*

Documento corto y claro. Sin letra pequeña.

## 1. Responsable del tratamiento

- **Responsable**: Diego Trujillo (AgriTrace — MVP en validación).
- **Contacto / canal de derechos Habeas Data**: diegotrujillor@gmail.com
- **Ámbito**: piloto en Valle del Cauca, Colombia.

## 2. Qué datos recolectamos

| Dato | Para qué |
|------|----------|
| Nombre completo | Identificar al productor |
| Correo electrónico | Acceso a la cuenta y comunicación |
| Teléfono celular | Acceso a la cuenta y soporte |
| Datos de finca/lote (nombre, ubicación, cultivo) | Trazabilidad agrícola |
| Actividades agrícolas (siembra, fertilización, cosecha, fotos, fechas) | Trazabilidad — son del productor |
| Registros de acceso (fecha, IP, dispositivo) | Seguridad y auditoría exigida por Ley 1581 |

No recolectamos datos sensibles ni de menores. No usamos los datos
para publicidad ni los vendemos.

## 3. Para qué los usamos

Únicamente para: (a) operar la trazabilidad agrícola del productor;
(b) validar el MVP durante el piloto. Base legal: **consentimiento
explícito** otorgado al registrarse.

## 4. Dónde se almacenan

En **territorio colombiano** — servidor Oracle Cloud, región Bogotá
(`sa-bogota-1`). **No hay transferencia internacional de datos.**
Cifrado en tránsito (HTTPS/TLS) y contraseñas con hash (bcrypt-class).
Todo acceso a datos personales queda registrado (Ley 1581).

## 5. Cuánto tiempo

Mientras dure la cuenta del productor en el piloto. Las copias de
respaldo rotan y se purgan naturalmente a los 7 días. Al solicitar
eliminación, los datos se borran del sistema activo de inmediato.

## 6. Tus derechos (ARCO — Habeas Data)

El titular puede en cualquier momento:

- **Acceder / portar** sus datos: descarga completa (JSON o CSV) desde
  la app o vía `GET /v1/users/me/export`.
- **Suprimir / derecho al olvido**: eliminación total desde la app o
  vía `DELETE /v1/users/me`. Borra la cuenta, finca, lotes y
  actividades; queda solo un registro auditable de que se ejerció el
  derecho (sin datos personales).
- **Rectificar**: corregir datos inexactos escribiendo al contacto.
- **Revocar el consentimiento**: equivale a solicitar la supresión.

Tiempo de respuesta a solicitudes por el canal de contacto: máximo
**10 días hábiles** (consulta) / **15 días hábiles** (reclamo), según
Ley 1581.

## 7. Compromiso de cierre limpio

Si el productor decide no continuar: puede descargar todos sus datos
(PDF/CSV) y solicitar su eliminación del servidor. Ver contrato de
piloto, sección "CIERRE LIMPIO".

## 8. Cambios

Cambios a esta política se comunican por el canal de contacto y se
publican con nueva versión y fecha. El uso continuado tras la
notificación implica aceptación.

---

> Esta política se enlaza desde la pantalla de registro de la app
> (ver `02-plan-consentimiento.md`). Registro SIC no aplica en el
> piloto (<10.000 titulares; Ley 1581 art. 25 / Decreto 1377).
