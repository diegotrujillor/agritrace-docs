# AgriTrace — Resumen Comercial (para decidir juntos)

*Documento corto, sin tecnicismos. Síntesis de toda la estrategia
comercial. Si después quieres el detalle, cada punto vive en los
archivos `01`–`10` de esta carpeta.*

---

## 1. Qué es y por qué

**AgriTrace** es una app de celular para que pequeños agricultores
registren —sin internet en la finca— qué hacen en sus cultivos
(siembra, fertilización, fumigación, cosecha) con fechas y fotos, y
puedan **demostrar trazabilidad** a compradores y cooperativas.

**El dolor real**: el agricultor pequeño no tiene cómo probar lo que
hizo; eso le cierra mercados que pagan mejor (orgánico, exportación,
comercio justo). Hoy lo lleva en cuadernos o en la memoria.

## 2. A quién le vendemos (cliente ideal)

Pequeños y medianos productores (5–50 hectáreas) en el **Valle del
Cauca** (piloto exclusivo). Tres tipos, todos cubiertos por el MVP:

- **Cacao** — entra primero (margen para pagar, necesita documentar
  fermentación/secado).
- **Caña panelera** — ciclos y molienda.
- **Hortalizas / frutas** — cosechas semanales, químicos, riegos.

No vamos (todavía) por cooperativas como cliente directo, exportadores,
café, ni grandes fincas. Eso es futuro.

## 3. Cómo llegamos a ellos

No contactamos al agricultor en frío. Vamos por **gremios y
cooperativas** (FEDECACAO, FEDEPANELA, Comité de Cafeteros, Secretaría
de Agricultura) y les pedimos que **nos refieran 2–3 productores**.
Primero la pregunta al gremio, después el pitch al productor referido,
por WhatsApp o llamada. Hay demo navegable para mostrar en 15 minutos:
**https://agritrace-demo.vercel.app**

## 4. Cuánto cobramos

| Momento | Precio | Idea |
|---|---|---|
| Mes 1 | **Gratis** (con contrato de compromiso) | Que lo prueben sin riesgo |
| Mes 2 y 3 | **$14.900 / mes** | Precio introductorio, baja la fricción del primer pago real |
| Mes 4 en adelante | **$29.900 / mes** | Tarifa full |

Importante: cuando preguntamos "¿pagaría?" siempre preguntamos por la
**tarifa full $29.900** — el descuento es solo para arrancar, no para
engañarnos sobre lo que vale.

## 5. El piloto (la apuesta concreta)

4 semanas, **5 productores** reales usando la app. Contrato de **una
página, sin letra pequeña, sin abogados**: acceso total, soporte por
WhatsApp, datos guardados en Colombia, y **cierre limpio** (si no
siguen: se llevan sus datos y se borran del servidor a su solicitud —
esto ya funciona de verdad en el sistema).

## 6. Cómo sabremos si funcionó

Medimos pocas cosas, claras: cuántos contactamos, cuántas demos,
cuántos firman el piloto, cuántos lo usan de verdad, y cuántos dicen
"sí pagaría $29.900". Al cierre del mes hay un veredicto simple:

- **Validación fuerte** → 2+ pilotos pagarían full → seguimos.
- **Tibia / pricing alto** → ajustamos precio o modelo.
- **Nadie paga** → pivote.

(Hay un tablero/CSV + reporte automático de una página para verlo sin
adivinar.)

## 7. Riesgos y qué hacemos

- **"Me copian la idea"** → la ventaja es la ejecución y los pilotos
  reales, no el secreto. Diez clientes pagando valen más que la idea.
- **"No pagan"** → para eso es el piloto: validar pago real antes de
  invertir más.
- **Conexión en finca** → la app funciona sin internet (offline).
- **Datos personales (Ley 1581)** → datos en Colombia, consentimiento
  explícito, derecho a descargar y a borrar — ya implementado.

## 8. Qué falta para lanzar

Lo técnico del MVP base está listo y desplegado (backend en
producción, app con pantallas de inicio, demo pública, cumplimiento
de datos). Falta el trabajo de producto de las siguientes etapas
(pantallas de finca/lote/actividades y el reporte PDF de trazabilidad)
y arrancar el contacto comercial con los gremios.

## 9. La decisión

Si esto te hace sentido, procedemos con: **(a)** liberar la app a los
primeros pilotos, **(b)** empezar a contactar gremios esta semana,
**(c)** construir las pantallas faltantes en paralelo.

> Una página para decidir. El resto es ejecución.
