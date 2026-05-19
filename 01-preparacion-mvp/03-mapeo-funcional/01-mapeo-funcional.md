# 🗺️ 2. Mapa Funcional

**Versión:** 1.1 (alineada con [`09-scope-mvp.md`](../09-scope-mvp.md) — Mayo 2026)

El **Mapa Funcional** describe cómo el **productor** interactúa con el sistema en el MVP, **desde el inicio de sesión hasta el registro offline de actividades y la exportación del reporte PDF de trazabilidad**.

Los flujos de cooperativa, exportador, comprador y administrador del sistema se conservan en este documento únicamente para referencia histórica y como roadmap de iteración futura — **no forman parte del MVP** ([`09-scope-mvp.md`](../09-scope-mvp.md) §4).

Sirve para:

- Visualizar **todo el flujo lógico del producto** antes del diseño UI.
- Alinear al equipo de negocio, UX y desarrollo sobre qué debe hacer el MVP.
- Identificar dependencias técnicas: API, base de datos y componentes.
- Evitar reprocesos antes de construir la arquitectura y el prototipo.

# 📊 Mapa Funcional y de Usuario — MVP AgriTrace

**Objetivo:** Describir los flujos principales del MVP AgriTrace y las interacciones entre los actores del sistema (productor, cooperativa, exportador, comprador y administrador).

---

| **Módulo / Proceso** | **Actor principal** | **Descripción funcional** | **Entrada de usuario** | **Resultado esperado** | **Dependencias técnicas** | **Prioridad (MoSCoW)** |
| --- | --- | --- | --- | --- | --- | --- |
| **Inicio de sesión y/o Registro** | Productor | Permite autenticarse o crear cuenta con datos básicos. | Email, teléfono, contraseña. | Sesión iniciada y perfil creado. | API de autenticación, DB usuarios | Must |
| **Registro de finca** | Productor | Registro de finca con ubicación, coordenadas y cultivo principal. | Nombre, municipio/vereda, coordenadas GPS, cultivo. | Finca creada con ID único. | DB de fincas, módulo geolocalización | Must |
| **Registro de lotes** | Productor | Crea y asocia lotes de cultivo a la finca registrada. | Nombre de lote, tipo de cultivo, área. | Lote vinculado a finca. | DB lotes, relación finca-lote | Must |
| **Registro de actividades agrícolas (offline)** | Productor | Registra siembra, fertilización, aplicación de químicos, cosecha y evidencias. Funciona sin internet. | Fotos, notas, fechas, tipo de insumo. | Actividad almacenada en historial local + cola de sincronización. | WatermelonDB local, almacenamiento multimedia | Must |
| **Sincronización automática** | Sistema | Sube actividades pendientes al servidor cuando hay conexión. | Conectividad detectada. | Cola vacía, registros con IDs autoritativos. | API sync, JWT auth | Must |
| **Timeline de actividades** | Productor | Visualiza historial cronológico de actividades de un lote. | Selección de lote. | Lista cronológica con fotos y notas. | DB local + remota | Must |
| **Exportar reporte PDF de trazabilidad** | Productor | Genera PDF con datos del productor, finca, lote y timeline para compartir con comprador o cooperativa. | Selección de lote. | Archivo PDF descargado/compartido. | Renderizador PDF **client-side en Flutter (app, offline-capable), Sprint 3** | Must |
| **Alertas locales** | Sistema | Recordatorios programados de actividades / clima básico. | Eventos programados. | Notificación in-app o SMS. | Cron local, opcionalmente SMS gateway | Should |
| **Adjuntar certificación existente como PDF** | Productor | Subir un PDF de una certificación que ya posee (ICA, orgánico, etc.) al perfil. | Archivo PDF. | PDF asociado al perfil del productor. | Almacenamiento multimedia | Could |
| **Generación de código QR público** | Sistema | Genera QR único por lote con URL pública verificable. | Datos del lote. | QR generado y URL pública. | API QR, servidor de trazabilidad | **Iteración futura** — diferido |
| **Consulta de trazabilidad pública (QR)** | Comprador / Exportador | Visualiza información del lote mediante escaneo del QR. | QR escaneado. | Página pública de trazabilidad. | API pública, front de consulta | **Iteración futura** — diferido |
| **Gestión de certificaciones (validación)** | Cooperativa | Valida y firma certificaciones de los productores. | Documentos PDF, decisiones. | Certificación validada y asociada al lote. | Módulo de validación | **Iteración futura** — diferido |
| **Dashboard de reportes (cooperativa)** | Cooperativa / Administrador | Visualiza métricas y estado de trazabilidad por finca, lote y productor. | Filtros. | Dashboard con indicadores. | Módulo analítico | **Iteración futura** — diferido |
| **Gestión de usuarios y auditoría (admin)** | Administrador | Controla accesos, auditorías y logs del sistema. | Acciones administrativas. | Reporte de accesos y cambios. | Módulo de seguridad, logging | **Iteración futura** — diferido |
| **Marketplace interno** | Productor / Exportador | Espacio para conectar productores y compradores. | Publicaciones, filtros. | Listado de ofertas y contactos. | API marketplace | **Iteración futura** — diferido |
| **Chat / mensajería** | Productor / Comprador | Comunicación directa en plataforma. | Mensajes. | Conversaciones almacenadas. | API mensajería | **Iteración futura** — diferido |

---

## 🔁 Flujo general de interacción (MVP)

1. **Productor** → se registra → crea finca y lotes → registra actividades **offline** → sincroniza automático cuando hay señal → exporta PDF de trazabilidad cuando lo necesita.

### Flujos diferidos (iteración futura, no MVP):

2. **Cooperativa** → valida certificaciones y consolida información.
3. **Exportador / Comprador** → escanea QR → consulta trazabilidad pública.
4. **Administrador** → monitorea y asegura el correcto funcionamiento del sistema.

---

## **🧩 Componentes del diagrama de flujo funcional y de usuario**

### **1. Nivel macro (visión general del sistema MVP)**

- Módulos del MVP:
    - **Registro y autenticación** (productor).
    - **Gestión de finca y lotes** (offline-capable).
    - **Registro de actividades agrícolas** (offline-first).
    - **Sincronización con backend.**
    - **Exportación de reporte PDF de trazabilidad.**

- Módulos diferidos (iteración futura):
    - Generación y consulta pública de QR.
    - Validación de certificaciones por cooperativa.
    - Dashboards de cooperativa/comprador.
    - Administración general / panel admin.

📘 *Flujo del MVP:*

Productor → (Registra finca y lotes) → (Registra actividades offline) → (Sincroniza automático cuando hay señal) → (Exporta PDF para mostrar al comprador o cooperativa)

---

### **2. Nivel medio (flujos de usuario por rol)**

Cada tipo de usuario tiene un diagrama que muestra su recorrido típico:

### **👨‍🌾 Productor (único actor activo en MVP):**

1. Inicia sesión / crea cuenta.
2. Registra finca (nombre, municipio/vereda, coordenadas GPS, cultivo principal).
3. Crea lote → selecciona cultivo y área.
4. Añade actividades (siembra, fertilización, aplicación de químicos, cosecha) — **funciona offline**.
5. Sube evidencia (fotos, notas).
6. La app sincroniza automáticamente cuando hay señal.
7. Exporta PDF de trazabilidad del lote cuando lo requiere.

---

### Flujos de otros actores — **diferidos a iteración futura, no implementados en MVP**:

### **🏢 Cooperativa (iteración futura):**

1. Visualiza productores afiliados.
2. Monitorea registros y lotes activos.
3. Consolida información para exportación.

### **🚛 Exportador (iteración futura):**

1. Consulta trazabilidad por lote o productor.
2. Descarga certificado digital.
3. Solicita validación documental.

### **🌎 Comprador (iteración futura):**

1. Escanea QR.
2. Visualiza trazabilidad (origen, fotos, certificaciones).

---

## 📌 Observaciones

- El flujo MVP prioriza **simplicidad y operatividad offline** (modo desconectado + sincronización automática).
- El reporte PDF exportable actúa como artefacto de trazabilidad principal en MVP. Se renderiza **client-side en Flutter (en la app, offline-capable)** y es un entregable de **Sprint 3** (decisión tomada; no es "local o backend"). El **QR público** queda diferido a iteración futura.
- Los datos cumplen Ley 1581 (Habeas Data) con aviso de privacidad y consentimiento explícito al registro.
- El MVP no incluye: pagos, marketplace, QR público, dashboards de cooperativa/comprador, certificación digital emitida por la plataforma, analítica avanzada, web admin, chat ni multi-idioma.

---

**Fin del documento — Mapa Funcional MVP AgriTrace (v1.1)**

© 2025-2026 Diego Trujillo.