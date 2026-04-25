# 🗺️ 2. Mapa Funcional

El **Mapa Funcional** describe cómo los diferentes tipos de usuarios—productor, cooperativa, exportador, comprador y administrador—interactúan con el sistema, **desde el inicio de sesión hasta la generación del código QR y la consulta de trazabilidad**.

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
| **Inicio de sesión y/o Registro** | Todos | Permite autenticarse o crear cuenta con datos básicos. | Usuario, contraseña, datos de contacto. | Sesión iniciada y perfil creado. | API de autenticación, DB usuarios | Must |
| **Registro de finca** | Productor | Registro de finca con ubicación, coordenadas y cultivos principales. | Nombre, ubicación, coordenadas GPS. | Finca creada con ID único. | DB de fincas, módulo geolocalización | Must |
| **Registro de lotes** | Productor | Crea y asocia lotes de cultivo a la finca registrada. | Nombre de lote, tipo de cultivo. | Lote vinculado a finca. | DB lotes, relación finca–lote | Must |
| **Registro de actividades agrícolas** | Productor | Registra siembra, fertilización, cosecha y evidencias. | Fotos, notas, fechas, tipo de insumo. | Actividad almacenada en historial del lote. | DB actividades, almacenamiento multimedia | Must |
| **Gestión de certificaciones** | Cooperativa | Consolida y valida certificaciones digitales de los productores. | Certificados, documentos PDF, fechas. | Certificación validada y asociada al lote. | Módulo de validación, almacenamiento seguro | Should |
| **Generación de código QR** | Sistema | Genera código QR único por lote con URL pública verificable. | Datos del lote y certificaciones. | QR generado y almacenado. | API QR, servidor de trazabilidad | Must |
| **Consulta de trazabilidad (QR)** | Comprador / Exportador | Permite visualizar toda la información del lote mediante escaneo. | QR escaneado. | Página con detalles de trazabilidad y certificado. | API pública, front de consulta | Must |
| **Dashboard de reportes** | Cooperativa / Administrador | Visualiza métricas y estado de trazabilidad por finca, lote y productor. | Parámetros de filtrado. | Dashboard actualizado con indicadores. | Módulo analítico, DB consolidada | Should |
| **Gestión de usuarios y auditoría** | Administrador | Controla accesos, auditorías y logs del sistema. | Filtros y acciones administrativas | Reporte de accesos y cambios. | Módulo de seguridad, logging | Should |
| **Notificaciones y alertas** | Sistema | Envía recordatorios automáticos (siembra, certificaciones próximas a vencer). | Eventos programados | Alertas en app o correo electrónico. | API de notificaciones, cron jobs | Could |
| **Marketplace interno (futuro)** | Productor / Exportador | Espacio para conectar productores y compradores. | Publicaciones, filtros de búsqueda. | Listado de ofertas y contactos. | API marketplace, motor de búsqueda | Won’t (MVP) |

---

## 🔁 Flujo general de interacción

1. **Productor** → se registra → crea finca y lotes → registra actividades → genera QR.
2. **Cooperativa** → valida certificaciones y consolida información.
3. **Exportador / Comprador** → escanea QR → consulta trazabilidad y certificaciones verificables.
4. **Administrador** → monitorea y asegura el correcto funcionamiento del sistema.

---

## **🧩 Componentes del diagrama de flujo funcional y de usuario**

### **1. Nivel macro (visión general del sistema)**

- Representa los módulos principales:
    - **Registro y autenticación.**
    - **Gestión de finca y lotes.**
    - **Registro de actividades agrícolas.**
    - **Certificaciones y documentos.**
    - **Generación y consulta de QR.**
    - **Dashboard / reportes.**
    - **Administración general.**

📘 *Ejemplo:*

Productor → (Registra finca y lotes) → (Registra actividades) → (Sistema genera QR) → (Comprador consulta QR)

---

### **2. Nivel medio (flujos de usuario por rol)**

Cada tipo de usuario tiene un diagrama que muestra su recorrido típico:

### **👨‍🌾 Productor:**

1. Inicia sesión / crea cuenta.
2. Registra finca (nombre, ubicación, coordenadas GPS).
3. Crea lote → selecciona cultivo.
4. Añade actividades (siembra, fertilización, cosecha).
5. Sube evidencia (fotos, certificados, clima).
6. Sistema genera QR.

### **🏢 Cooperativa:**

1. Visualiza productores afiliados.
2. Monitorea registros y lotes activos.
3. Consolida información para exportación.

### **🚛 Exportador:**

1. Consulta trazabilidad por lote o productor.
2. Descarga certificado digital.
3. Solicita validación documental.

### **🌎 Comprador:**

1. Escanea QR.
2. Visualiza trazabilidad (origen, fotos, certificaciones).

---

## 📌 Observaciones

- El flujo prioriza **simplicidad y operatividad offline** (modo desconectado + sincronización).
- El **QR actúa como identificador universal del producto agrícola**.
- Los datos de certificación se almacenan de forma segura y verificable.
- El MVP no incluye pagos, marketplace ni analítica avanzada.

---

**Fin del documento — Mapa Funcional MVP AgriTrace (v1.0)**

© 2025 Diego Trujillo.