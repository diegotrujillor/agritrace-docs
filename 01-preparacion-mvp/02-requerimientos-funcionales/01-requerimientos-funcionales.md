# 📝 1. DRF y DRnF

# 📘 Documento de Requerimientos Funcionales (DRF v1.0) — MVP AgriTrace

**Proyecto:** AgriTrace — Plataforma de Trazabilidad y Exportación Sostenible

**Versión:** 1.1 (alineada con [`09-scope-mvp.md`](../09-scope-mvp.md) — Mayo 2026)

**Fecha original:** 14 de octubre de 2025
**Última revisión:** Mayo 2026

**Elaborado por:** Diego Trujillo

**Objetivo:** Definir los requerimientos funcionales y no funcionales del MVP AgriTrace. Este documento se alinea con la **fuente única de verdad** del alcance: [`09-scope-mvp.md`](../09-scope-mvp.md). Requerimientos no presentes aquí como Must/Should quedan diferidos a iteración futura.

---

## 🎯 1. Contexto y propósito

AgriTrace ofrece a **pequeños y medianos agricultores del Valle del Cauca** (5-50 hectáreas) una app móvil **offline-first** para digitalizar la trazabilidad de sus cultivos (cacao, café, aguacate, frutas exóticas). El servidor cumple Ley 1581 de Habeas Data.

El MVP se enfoca exclusivamente en:

- Registrar productores, fincas y lotes agrícolas.

- Documentar actividades de cultivo con evidencias (fotos, notas) — funciona sin internet.

- Sincronización automática cuando hay señal.

- Exportar reporte PDF de trazabilidad para mostrar al comprador, cooperativa o certificador.

**Lo que el MVP NO incluye** (diferido a iteración futura, ver [`09-scope-mvp.md`](../09-scope-mvp.md) §4): generación y consulta pública por QR, dashboards para cooperativas/compradores, certificaciones digitales emitidas por la plataforma, marketplace, chat con compradores, web app, multi-idioma, blockchain.

---

## 👥 2. Actores involucrados

| Actor | Descripción | Intereses principales |
| --- | --- | --- |
| **Productor agrícola** | Agricultor o pequeño propietario rural. | Registrar sus cultivos, fotos y certificaciones. |
| **Cooperativa** | Organización que agrupa productores. | Monitorear fincas, recolectar información centralizada. |
| **Exportador** | Empresa que comercializa productos agrícolas. | Obtener trazabilidad verificable y certificaciones digitales. |
| **Comprador internacional** | Importadora o distribuidora (UE, Japón, EE. UU.). | Verificar autenticidad y sostenibilidad del producto. |
| **Administrador del sistema** | Equipo AgriTrace. | Gestionar usuarios, auditorías, métricas y soporte. |

---

## 🗓️ 3. Escenario de reunión de levantamiento

**Participantes (simulados):**

- María Torres — Productora de cacao orgánico.

- Luis Herrera — Representante cooperativa Asoprofrutas.

- Carlos Álvarez — Exportador de frutas exóticas.

- Sofía Jiménez — Importadora europea.

- Diego Trujillo — Arquitecto y moderador.

**Duración:** 2 horas

**Modalidad:** Taller presencial con simulación de flujo de uso del sistema.

## **🗣️ Discusión por temas**

### **1️⃣ — Registro y gestión de productores**

María (productora):

“Nos cuesta mantener registros claros de cada lote, cuándo se sembró, qué se aplicó o cuándo se cosechó. Todo lo anotamos en libretas.”

Luis (cooperativa):

“Necesitamos tener toda la información de los productores en un solo sitio: qué cultivan, en qué estado está la finca, certificaciones, etc.”

RF: 01, 02, 03 y 04

RNF: 01 y 02

### **2️⃣ — Registro de actividades y trazabilidad**

María:

“Si yo aplico un fertilizante o recojo la cosecha, quisiera poder marcarlo desde el celular, con foto.”

Carlos (exportador):

“Nos interesa saber exactamente de qué lote viene cada caja. Cuando hay una devolución, rastrear el origen es un dolor de cabeza.”

RF: 05, 06, 07 y 08

RNF: 03 y 04

### **3️⃣ — Control de calidad y certificación**

Carlos:

“Los compradores en Europa nos piden demostrar que el producto es orgánico, con fechas, fotos y certificaciones digitales.”

Sofía (importadora europea):

“Nos interesa escanear un QR y ver toda la trazabilidad, incluso fotos y ubicación del lote.”

RF: 09, 10 y 11

FNF: 05 y 06

### **4️⃣ — Dashboard y analítica**

Luis (cooperativa):

“Queremos ver en un solo panel el estado de todos los productores: quién ha cosechado, quién tiene retrasos, etc.”

Diego:

“También podríamos ofrecer métricas de productividad, sostenibilidad o huella de carbono.”

RF: 12, 13 y 14

FNF: 07 y 08

### **5️⃣ — Conexión productor ↔ comprador**

Sofía (importadora):

“Si pudiera buscar productores certificados en una plataforma única, sería ideal.”

Carlos:

“Podríamos publicar nuestros lotes disponibles y recibir solicitudes directamente.”

RF: 15, 16 y 17

FNF: 09 y 10

### **6️⃣ — Incentivos y usabilidad**

María:

“Si la app me devuelve algo útil, como recordatorios o alertas, la usaría más.”

Luis:

“También podría servir para reportar clima o plagas.”

RF: 18, 19 y 20

FNF: 11 y 12

---

## ⚙️ 4. Requerimientos funcionales (RF)

| Código | Descripción | Prioridad |
| --- | --- | --- |
| **RF-01** | Crear perfiles de productores con datos básicos (nombre, ubicación, cultivo principal). | Must |
| **RF-02** | Registrar lotes agrícolas y ciclos de cultivo (siembra, cosecha, fertilización). | Must |
| **RF-03** | Registrar actividades de cultivo con fecha, notas y fotos. | Must |
| **RF-04** | Visualizar historial cronológico (timeline) de actividades por lote. | Must |
| **RF-05** | Funcionar offline por 14+ días sin pérdida de datos. | Must |
| **RF-06** | Sincronización automática bidireccional cuando hay señal. | Must |
| **RF-07** | Gestión de múltiples fincas y múltiples lotes por finca con GPS. | Must |
| **RF-08** | Exportar reporte PDF de trazabilidad de un lote. | Must |
| **RF-09** | Alertas locales de actividades programadas (recordatorios). | Should |
| **RF-10** | Alertas climáticas simples (si hay acceso a API de clima). | Should |
| **RF-11** | Indicador de estado de sincronización (offline / sincronizando / sincronizado). | Should |
| **RF-12** | SMS/USSD fallback para alertas a teléfonos básicos. | Should |
| **RF-13** | Adjuntar certificados existentes como documentos PDF al perfil. | Could |
| **RF-14** | Generar y asociar códigos QR únicos por lote. | Iteración futura — diferido (marketplace) |
| **RF-15** | Consultar trazabilidad pública mediante QR. | Iteración futura — diferido (marketplace) |
| **RF-16** | Gestión multi-productor por cooperativas (dashboard). | Iteración futura — diferido |
| **RF-17** | Emitir certificado digital de trazabilidad (firma de la plataforma). | Iteración futura — diferido (requiere partner certificador) |
| **RF-18** | Dashboard analítico para exportadores/compradores. | Iteración futura — diferido (sin demanda validada) |
| **RF-19** | Marketplace interno entre productores y compradores. | Iteración futura — diferido |
| **RF-20** | Chat o mensajería entre usuarios. | Iteración futura — diferido |
| **RF-21** | Web admin dashboard. | Iteración futura — diferido |

> **Nota**: la priorización refleja la revalidación post-encuesta de partes interesadas (Mayo 2026). Funcionalidades de QR público, certificación digital y dashboards de actores no-productor se difieren porque la encuesta n=4 mostró cero demanda firme y los founders priorizan validar primero adopción del registro de actividades por agricultores ([`09-scope-mvp.md`](../09-scope-mvp.md) §4-§5).

---

## 🧱 5. Requerimientos no funcionales (RNF)

| Código | Descripción | Prioridad |
| --- | --- | --- |
| **RNF-01** | Interfaz simple y adaptable a móviles Android de gama baja. | Must |
| **RNF-02** | Modo offline-first con sincronización posterior automática. | Must |
| **RNF-03** | Tiempo de respuesta < 2 segundos en consultas locales (offline). | Must |
| **RNF-04** | Almacenamiento seguro de datos e imágenes (cifrado en tránsito y en reposo). | Must |
| **RNF-05** | Cumplimiento con la Ley 1581 de Habeas Data. | Must |
| **RNF-06** | Comunicación segura (TLS 1.2+ + JWT). | Must |
| **RNF-07** | Tamaño máximo de app móvil: 50 MB. | Should |
| **RNF-08** | Disponibilidad mínima del 99% mensual del backend de sincronización. | Should |
| **RNF-09** | Idioma: español (multi-idioma diferido a iteración futura). | Must |
| **RNF-10** | Sistema multi-idioma (español/inglés). | Iteración futura — diferido |
| **RNF-11** | Dashboard web responsive. | Iteración futura — diferido |
| **RNF-12** | Escalabilidad horizontal del sistema (microservicios / k8s). | Iteración futura — diferido |

---

## 📊 6. Priorización (MoSCoW)

| Categoría | Definición | Requerimientos incluidos |
| --- | --- | --- |
| **Must Have** | Imprescindibles para MVP | RF-01 a RF-08, RNF-01 a RNF-06, RNF-09 |
| **Should Have** | Deseables para experiencia completa | RF-09 a RF-12, RNF-07 a RNF-08 |
| **Could Have** | Opcionales si hay tiempo | RF-13 |
| **Won't Have (iteración futura)** | Fuera del alcance MVP inicial | RF-14 a RF-21, RNF-10 a RNF-12 (QR público, dashboards, certificación digital, marketplace, chat, web app, multi-idioma) |

---

## 🧩 7. Casos de uso principales

### **CU-01: Registro de productor**

**Actor:** Productor

**Flujo principal:**
1. El usuario se registra con nombre, correo y número de finca.

2. Completa información básica (cultivos, ubicación, extensión).

3. El sistema genera un ID único de productor.

**Resultado:** Productor registrado y visible en dashboard de cooperativa.

---

### **CU-02: Registro de lote y actividades (offline-first)**

**Actor:** Productor

**Flujo principal:**
1. El usuario crea un nuevo lote y define cultivo principal (con o sin conexión).

2. Registra actividades: siembra, fertilización, aplicación de químicos, cosecha — con fecha, fotos y notas.

3. La app almacena todo localmente (WatermelonDB) y marca como `pending_sync`.

4. Cuando hay conexión, los datos se sincronizan automáticamente al backend.

5. El usuario exporta un reporte PDF de trazabilidad del lote cuando lo requiera.

**Resultado:** Lote con historial completo de actividades, exportable en PDF para mostrar al comprador o cooperativa.

---

### **CU-03: Exportar y compartir reporte de trazabilidad**

**Actor:** Productor

**Flujo principal:**
1. Desde la vista del lote, el productor toca "Exportar PDF de trazabilidad".

2. La app genera un PDF con: datos del productor, finca, lote, timeline de actividades, fotos asociadas.

3. El productor comparte el PDF vía WhatsApp / email / impresión al comprador, cooperativa o certificador.

**Resultado:** Comprador o cooperativa recibe un documento estructurado en vez de un cuaderno o respuesta verbal.

> **CU-04 a CU-07** (consulta pública por QR, dashboard cooperativa, validación certificaciones, marketplace) quedan diferidos a iteración futura. Ver [`09-scope-mvp.md`](../09-scope-mvp.md) §4.

---

## 🧭 8. Restricciones y supuestos

- MVP orientado a cultivos de pequeño/mediano productor del **Valle del Cauca**: cacao, café, aguacate, frutas exóticas.
- Tamaño de finca objetivo: 5-50 hectáreas.
- Conectividad rural intermitente — la app debe funcionar 14+ días sin internet.
- Base tecnológica: Node.js (backend), Flutter+Dart (app móvil), WatermelonDB (almacenamiento local móvil), PostgreSQL (DB del servidor), Docker (infraestructura — proveedor exacto en [`/01-preparacion-mvp/06-infraestructura/01-decisiones-infra.md`](../06-infraestructura/01-decisiones-infra.md)).
- MVP en una sola región (Valle del Cauca). Expansión nacional o LATAM queda diferida.
- No incluye pasarelas de pago, marketplace, certificación digital ni dashboards para actores no-productor en MVP.
- Cumplimiento Ley 1581 (Habeas Data Colombia) con aviso de privacidad y consentimiento explícito.

---

## 📋 9. Entregables de la fase de requerimientos

- Acta de reunión de levantamiento (simulada).
- Documento DRF v1.0 (este archivo).
- Diagrama de casos de uso.
- Lista priorizada de features (MoSCoW).
- Flujos de usuario para diseño UI/UX (Figma).

---

## ✅ 10. Conclusiones

- El MVP debe ser **simple, usable sin conexión y enfocado en el registro de actividades del productor.**
- El "wedge" validado por encuesta es el **registro digital de actividades + sincronización offline**, no la trazabilidad pública.
- Funcionalidades dirigidas a compradores, cooperativas y certificadores quedan diferidas hasta validar adopción real del productor.
- La siguiente fase consiste en validación comercial paralela ([`../10-comercial-gtm/`](../10-comercial-gtm/)) y construcción del backend + app móvil con las 10 pantallas priorizadas en [`09-scope-mvp.md`](../09-scope-mvp.md).

---

**Fin del documento — DRF v1.1 (MVP AgriTrace)**

© 2025-2026 Diego Trujillo. Todos los derechos reservados.