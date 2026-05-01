# 📝 1. DRF y DRnF

# 📘 Documento de Requerimientos Funcionales (DRF v1.0) — MVP AgriTrace

**Proyecto:** AgriTrace — Plataforma de Trazabilidad y Exportación Sostenible

**Versión:** 1.0

**Fecha:** 14 de octubre de 2025

**Elaborado por:** Diego Trujillo

**Objetivo:** Definir los requerimientos funcionales y no funcionales del MVP AgriTrace, basados en la reunión de levantamiento con actores clave del ecosistema agroexportador.

---

## 🎯 1. Contexto y propósito

AgriTrace busca ofrecer una plataforma que permita a productores agrícolas, cooperativas y exportadores: **digitalizar la trazabilidad de sus cultivos**, certificar procesos sostenibles y conectar con compradores internacionales interesados en transparencia y sostenibilidad.

El MVP inicial se enfocará en:

- Registrar productores, fincas y lotes agrícolas.

- Documentar actividades de cultivo con evidencias (fotos, notas).

- Generar códigos QR de trazabilidad verificables.

- Mostrar dashboards de rendimiento y reportes de exportación.

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

FNF: 01 y 02

### **2️⃣ — Registro de actividades y trazabilidad**

María:

“Si yo aplico un fertilizante o recojo la cosecha, quisiera poder marcarlo desde el celular, con foto.”

Carlos (exportador):

“Nos interesa saber exactamente de qué lote viene cada caja. Cuando hay una devolución, rastrear el origen es un dolor de cabeza.”

RF: 05, 06, 07 y 08

FNF: 03 y 04

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
| **RF-01** | Crear perfiles de productores con datos básicos (nombre, ubicación, cultivos). | Must |
| **RF-02** | Registrar lotes agrícolas y ciclos de cultivo (siembra, cosecha, fertilización). | Must |
| **RF-03** | Adjuntar certificados y documentos escaneados (orgánico, ICA, etc.). | Must |
| **RF-04** | Gestión multi-productor por cooperativas. | Should |
| **RF-05** | Registrar actividades de cultivo con fecha, notas y fotos. | Must |
| **RF-06** | Generar y asociar códigos QR únicos por lote. | Must |
| **RF-07** | Consultar la trazabilidad completa de un lote mediante QR. | Must |
| **RF-08** | Generar reportes automáticos (PDF/Excel). | Should |
| **RF-09** | Subir y validar certificaciones digitales. | Should |
| **RF-10** | Emitir certificado digital de trazabilidad. | Should |
| **RF-11** | Compartir trazabilidad mediante enlace seguro. | Should |
| **RF-12** | Dashboard consolidado por finca, cultivo y productor. | Should |
| **RF-13** | Indicadores de rendimiento y avance (% cosechado, entregas). | Should |
| **RF-14** | Marketplace interno entre productores y compradores. | Could |
| **RF-15** | Chat o mensajería entre usuarios. | Could |
| **RF-16** | Alertas y recordatorios automáticos (fechas, clima, fertilización). | Could |
| **RF-17** | Registro manual de eventos climáticos. | Could |
| **RF-18** | Generar puntaje de cumplimiento (gamificación). | Could |

---

## 🧱 5. Requerimientos no funcionales (RNF)

| Código | Descripción | Prioridad |
| --- | --- | --- |
| **RNF-01** | Interfaz simple y adaptable a móviles de gama baja. | Must |
| **RNF-02** | Modo offline con sincronización posterior. | Must |
| **RNF-03** | Tiempo de respuesta < 2 segundos en consultas. | Must |
| **RNF-04** | Almacenamiento seguro de datos e imágenes. | Must |
| **RNF-05** | Cumplimiento con la Ley 1581 de protección de datos. | Must |
| **RNF-06** | Sistema multilenguaje (español/inglés). | Should |
| **RNF-07** | Dashboard responsive (tablet y escritorio). | Should |
| **RNF-08** | Actualización de datos en tiempo casi real (<15min). | Should |
| **RNF-09** | Comunicación segura (TLS + JWT). | Must |
| **RNF-10** | Escalabilidad horizontal del sistema (microservicios). | Should |
| **RNF-11** | Tamaño máximo de app móvil: 50MB. | Should |
| **RNF-12** | Disponibilidad mínima del 99% mensual. | Should |

---

## 📊 6. Priorización (MoSCoW)

| Categoría | Definición | Requerimientos incluidos |
| --- | --- | --- |
| **Must Have** | Imprescindibles para MVP | RF-01 a RF-08, RNF-01 a RNF-05, RNF-09 |
| **Should Have** | Deseables para experiencia completa | RF-09 a RF-13, RNF-06 a RNF-08, RNF-10 |
| **Could Have** | Opcionales / futura versión | RF-14 a RF-18, RNF-11 a RNF-12 |
| **Won’t Have (por ahora)** | Fuera del alcance MVP inicial | Marketplace avanzado, IA predictiva de rendimiento |

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

### **CU-02: Registro de lote y trazabilidad**

**Actor:** Productor / Cooperativa

**Flujo principal:**
1. El usuario crea un nuevo lote y define cultivo.

2. Registra eventos (siembra, fertilización, cosecha).

3. El sistema asocia código QR y almacena evidencia.

4. Cualquier comprador puede consultar historial escaneando el QR.

**Resultado:** Lote trazable con historial completo.

---

### **CU-03: Consulta de trazabilidad (comprador)**

**Actor:** Comprador internacional

**Flujo principal:**
1. Escanea el QR impreso en el producto.

2. Accede a página con historial de lote, fotos, certificaciones y ubicación.

3. Descarga certificado digital.

**Resultado:** Verificación de autenticidad y trazabilidad.

---

## 🧭 8. Restricciones y supuestos

- MVP orientado a cultivos de exportación (cacao, frutas exóticas, café).
- Base tecnológica: Go/Node.js (backend), Flutter (app), PostgreSQL (DB), OpenStack (infraestructura).
- MVP prioriza Colombia, con capacidad de expansión a LATAM.
- No incluye pasarelas de pago ni marketplace completo en versión inicial.

---

## 📋 9. Entregables de la fase de requerimientos

- Acta de reunión de levantamiento (simulada).
- Documento DRF v1.0 (este archivo).
- Diagrama de casos de uso.
- Lista priorizada de features (MoSCoW).
- Flujos de usuario para diseño UI/UX (Figma).

---

## ✅ 10. Conclusiones

- El MVP debe ser **simple, usable sin conexión, y enfocado en trazabilidad y QR.**
- Productores valoran la facilidad y los recordatorios automáticos.
- Exportadores y compradores priorizan **confianza, transparencia y certificados verificables.**
- La fase siguiente consistirá en **diagramar los flujos UX/UI y modelo de datos** para pasar a desarrollo.

---

**Fin del documento — DRF v1.0 (MVP AgriTrace)**

© 2025 Diego Trujillo. Todos los derechos reservados.