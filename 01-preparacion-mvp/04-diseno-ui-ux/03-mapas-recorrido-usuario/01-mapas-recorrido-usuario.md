# 🛣️ 3.3 User Journey Maps y Flujos de Usuario

**Versión:** 1.0 - MVP

**Fecha:** Noviembre 2025

**Objetivo:** Mapear experiencias de usuario y puntos de dolor para optimizar el diseño UI/UX

---

## 1. Journey Map: Productor (Actor Principal)

### 👤 Persona: Juan Gómez

**Perfil:**

- Edad: 42 años
- Ubicación: Zona Rural, Valle del Cauca
- Cultivo: Café especial (3 hectáreas)
- Experiencia digital: Media-baja
- Dispositivo: Smartphone Android básico
- Conectividad: Intermitente (3G/4G)

---

### 📱 Fase 1: Descubrimiento y Onboarding

### Contexto

Juan escucha sobre AgriTrace en una capacitación de su cooperativa. Le prometen mejor acceso a mercados internacionales si certifica su trazabilidad.

### Puntos de contacto

1. **Descarga de app** (Play Store/App Store)
2. **Pantalla de bienvenida**
    - Mensaje: "Certifica tus cultivos y accede a mercados premium"
    - 3 slides con beneficios visuales
3. **Registro inicial**
    - Nombre completo
    - Celular (con verificación SMS)
    - Correo (opcional)
    - Contraseña segura

### Puntos de dolor potenciales

- ❌ Formularios muy largos
- ❌ Lenguaje técnico
- ❌ Validación de celular que falla
- ❌ No entiende para qué sirve cada campo

### Soluciones de diseño

- ✅ Registro progresivo (solo 4 campos iniciales)
- ✅ Tooltips contextuales con ejemplos
- ✅ Validación en tiempo real con mensajes amigables
- ✅ Opción de "Saltar" secciones opcionales

---

### 📍 Fase 2: Configuración de Finca

### Contexto

Juan necesita registrar su finca "La Esperanza" con sus 3 lotes de café.

### Pasos del flujo

1. **Dashboard inicial** → Botón "Registrar mi primera finca"
2. **Formulario de finca:**
    - Nombre de la finca
    - Ubicación (autocompletado con GPS)
    - Área total (hectáreas)
    - Foto de la finca (opcional)
3. **Confirmación en mapa:**
    - Visualización de pin en mapa
    - Opción de ajustar manualmente
4. **Creación de lotes:**
    - Modal: "Divide tu finca en lotes"
    - Campos por lote:
        - Nombre (ej: "Lote Norte")
        - Tipo de cultivo (selector con iconos)
        - Área del lote

### Tiempo estimado

⏱️ 5-8 minutos (con conexión estable)

### Puntos de dolor

- ❌ GPS no funciona en zona rural
- ❌ No sabe cómo dividir lotes
- ❌ Pierde progreso si se va la conexión

### Soluciones

- ✅ Entrada manual de coordenadas alternativa
- ✅ Sugerencias: "Puedes crear lotes por edad de siembra o variedad"
- ✅ **Auto-guardado cada 30 segundos**
- ✅ Modo offline con sincronización posterior

---

### 🌱 Fase 3: Registro de Actividades (Uso Recurrente)

### Contexto

Juan realiza fertilización orgánica en el "Lote Norte" y quiere documentarlo.

### Flujo optimizado

1. **Acceso rápido:**
    - Dashboard → Card "Lote Norte" → Botón "Registrar actividad"
2. **Selector de tipo:**
    - Grid de iconos grandes: 🌱 Siembra | 💧 Riego | 🧪 Fertilización | ✂️ Poda | 📦 Cosecha
3. **Formulario contextual** (campos según tipo):
    - Fecha (pre-llenada con hoy)
    - Tipo de insumo (si aplica)
    - Cantidad/Dosis
    - Notas (opcional)
    - **Foto** (botón grande: "Tomar evidencia")
4. **Confirmación:**
    - Preview de la actividad
    - Botón "Guardar" (verde grande)

### Tiempo estimado

⏱️ 2-3 minutos

### Puntos de dolor

- ❌ Foto muy pesada (señal débil)
- ❌ Olvida registrar actividades a tiempo
- ❌ Tipear en campo es incómodo

### Soluciones

- ✅ Compresión automática de imágenes
- ✅ Notificaciones recordatorias semanales
- ✅ **Entrada por voz** para notas (dictado)
- ✅ Templates pre-llenados para actividades frecuentes

---

### 🏆 Fase 4: Generación de QR y Venta

### Contexto

Juan está listo para cosechar y quiere generar el QR para su comprador internacional.

### Flujo

1. **Revisión de trazabilidad:**
    - Lote → Botón "Ver historial completo"
    - Timeline con todas las actividades
    - Indicador de completitud: "85% documentado"
2. **Generar QR:**
    - Botón prominente: "Generar código QR"
    - Modal: "Tu lote está listo para certificación"
    - Preview del QR
    - Opciones:
        - Descargar imagen
        - Compartir por WhatsApp
        - Imprimir
3. **Compartir con comprador:**
    - Mensaje pre-llenado: "Te comparto la trazabilidad de mi café certificado"

### Puntos de dolor

- ❌ QR se ve pixelado al imprimir
- ❌ No sabe cómo enviar a compradores internacionales

### Soluciones

- ✅ Exportación en alta resolución (PNG, SVG)
- ✅ Tutorial integrado: "Cómo compartir tu QR"
- ✅ Integración directa con WhatsApp Business

---

## 2. Journey Map: Cooperativa (Validador) — ⏸️ PHASE 2

> **Nota:** Este flujo es Phase 2. El MVP se enfoca solo en el productor (Section 1).

### 👤 Persona: María López

**Perfil:**

- Rol: Coordinadora de Certificaciones
- Edad: 35 años
- Ubicación: Oficina urbana
- Dispositivo: Laptop + Tablet
- Experiencia: Alta en gestión agrícola, media en tecnología

---

### 📊 Fase 1: Onboarding Cooperativa

### Contexto

La cooperativa adopta AgriTrace para certificar a sus 120 productores asociados.

### Flujo

1. **Registro institucional:**
    - Datos de la cooperativa
    - NIT/RUT
    - Certificaciones que valida (selección múltiple)
2. **Invitación de productores:**
    - Carga masiva de contactos (CSV)
    - Envío automático de invitaciones por SMS/Email
3. **Dashboard de gestión:**
    - Lista de productores asociados
    - Estados: Pendiente | En proceso | Certificado

### Tiempo estimado

⏱️ 30 minutos (configuración inicial)

---

### ✅ Fase 2: Validación de Certificaciones

### Contexto

María debe revisar y aprobar las certificaciones de productores.

### Flujo

1. **Cola de revisión:**
    - Notificación: "5 solicitudes pendientes"
    - Tarjetas ordenadas por prioridad
2. **Revisión detallada:**
    - Datos del productor
    - Documentos adjuntos (PDF)
    - Historial de actividades del lote
    - Checklist de requisitos
3. **Decisión:**
    - ✅ Aprobar (con firma digital)
    - ❌ Rechazar (con comentarios)
    - ⏸️ Solicitar correcciones

### Puntos de dolor

- ❌ Muchos productores para revisar
- ❌ Documentos en formatos variados
- ❌ Falta información clave

### Soluciones

- ✅ Sistema de priorización automática
- ✅ Visor unificado de documentos
- ✅ Checklist automatizado (validación de campos)
- ✅ Comentarios predefinidos para agilizar rechazos

---

### 📈 Fase 3: Monitoreo Continuo

### Contexto

María necesita generar reportes para auditorías externas.

### Flujo

1. **Dashboard analítico:**
    - Métricas clave:
        - Productores certificados
        - Hectáreas trazadas
        - Actividades registradas (últimos 30 días)
2. **Generación de reportes:**
    - Filtros: Rango de fechas, tipo de certificación, región
    - Formatos: PDF, Excel
3. **Alertas automáticas:**
    - Certificaciones próximas a vencer
    - Productores sin actividad reciente

### Soluciones

- ✅ Exportación de datos en formatos estándar
- ✅ Gráficos interactivos
- ✅ Sistema de alertas configurable

---

## 3. Journey Map: Comprador/Exportador — ⏸️ PHASE 2

> **Nota:** Este flujo es Phase 2. El MVP no incluye funcionalidad de comprador/marketplace.

### 👤 Persona: Thomas Müller

**Perfil:**

- Rol: Comprador de café especial (Alemania)
- Edad: 48 años
- Prioridad: Transparencia y sostenibilidad
- Dispositivo: Smartphone + Desktop

---

### 🔍 Fase 1: Consulta de Trazabilidad (Experiencia Pública)

### Contexto

Thomas recibe un QR de un productor colombiano y quiere verificar la calidad del café.

### Flujo

1. **Escaneo del QR:**
    - Cámara del celular o app
    - Redirección instantánea a página pública
2. **Landing page de trazabilidad:**
    - Hero: Foto del lote + Nombre del productor
    - Badge destacado: "✅ Certificado por [Cooperativa]"
    - Secciones:
        - Información del lote
        - Timeline de actividades (con fotos)
        - Certificaciones (descargables)
        - Ubicación en mapa
        - Datos de contacto del productor
3. **Verificación de autenticidad:**
    - Sello digital con timestamp
    - Enlace a blockchain (futuro)

### Tiempo estimado

⏱️ 2-3 minutos

### Puntos de dolor

- ❌ QR no abre o da error 404
- ❌ Información incompleta
- ❌ No puede descargar certificados

### Soluciones

- ✅ URLs permanentes (no expiran)
- ✅ Validación previa antes de generar QR
- ✅ Descarga directa de PDFs
- ✅ Traducción automática (inglés/alemán)

---

### 📧 Fase 2: Contacto con Productor

### Flujo

1. **Botón de contacto:**
    - "Contactar productor" → Formulario
2. **Mensaje pre-llenado:**
    - "Hola [Nombre], me interesa tu café del lote [X]"
3. **Notificación al productor:**
    - WhatsApp/Email con datos del comprador

### Soluciones

- ✅ Protección de datos (email no público)
- ✅ Sistema anti-spam
- ✅ Traducción automática de mensajes

---

## 4. Journey Map: Administrador del Sistema — ⏸️ PHASE 2+

> **Nota:** Este flujo es Phase 2+. El MVP usa autenticación básica; admin panel se agrega después.

### 👤 Persona: Carlos Ramírez

**Perfil:**

- Rol: Admin AgriTrace
- Responsabilidad: Seguridad y operación
- Herramientas: Panel web avanzado

---

### 🛡️ Fase 1: Gestión de Usuarios

### Flujo

1. **Panel de administración:**
    - Lista de usuarios con filtros
    - Estados: Activo | Suspendido | Pendiente verificación
2. **Acciones:**
    - Verificar identidad manual
    - Activar/Desactivar cuentas
    - Resetear contraseñas
    - Ver logs de actividad

---

### 📊 Fase 2: Auditoría y Seguridad

### Flujo

1. **Dashboard de logs:**
    - Eventos críticos
    - Intentos de acceso fallidos
    - Cambios en certificaciones
2. **Reportes de auditoría:**
    - Exportación de logs
    - Alertas de anomalías

### Soluciones

- ✅ Sistema de alertas en tiempo real
- ✅ Integración con herramientas de monitoreo
- ✅ Backup automático diario

---

## 5. Flujo de Datos: Diagrama de Integración

```mermaid
graph TD
    A[Productor registra actividad] -->|Offline| B[Almacenamiento local]
    B -->|Sync automática| C[Backend AgriTrace]
    C --> D[Validación cooperativa]
    D -->|Aprobada| E[Generación QR]
    E --> F[Base de datos pública]
    F --> G[Comprador escanea QR]
    G --> H[Visualización trazabilidad]

```

---

## 6. Métricas de Éxito por Fase (KPIs)

### Onboarding

- ✅ 80%+ usuarios completan registro en < 5 min
- ✅ 90%+ activan funcionalidad offline

### Uso recurrente

- ✅ Promedio 3+ actividades registradas por semana
- ✅ 70%+ suben foto en cada registro

### Validación

- ✅ Tiempo promedio de revisión < 10 min
- ✅ 95%+ certificaciones aprobadas en primera instancia

### Consulta pública

- ✅ Tiempo de carga QR < 2 segundos
- ✅ 85%+ visitantes ven timeline completo

---

## 7. 🎯 PRIORIZACIÓN DE PANTALLAS MVP (ENTRADA PRINCIPAL PARA DESARROLLO)

**Este es el plan de desarrollo ejecutable para el MVP. Contrasta con `01-priorizacion-features-mvp.md` para validar alineamiento feature-screen.**

### ⚡ MVP = 10 Pantallas en 6 Semanas (Flujo Productor Solamente)

**Status:** Aprobado para desarrollo kickoff
**Pilot Region:** Valle del Cauca o Eje Cafetero (Huila, Tolima, Caldas)
**Plataforma:** Mobile only (Flutter)

---

### 🚀 **SEMANA 1-2: Autenticación e Onboarding (3 pantallas)**

| Pantalla | Flujo | Prioridad | Notes |
|----------|-------|-----------|-------|
| **1. Bienvenida** | App abre → Hero con CTA | P0 | Logo + 3 slides beneficios + "Ingresar" / "Crear cuenta" |
| **2. Registro** | Crear cuenta productor | P0 | Nombre, email, teléfono, contraseña. Verificación SMS. Rol = Productor. |
| **3. Login** | Acceso recurrente | P0 | Email + password. Link "recuperar contraseña". |

**Hito:** Usuario autenticado, puede acceder a dashboard vacío

---

### 🌾 **SEMANA 2-3: Gestión de Fincas y Lotes (5 pantallas)**

| Pantalla | Flujo | Prioridad | Notes |
|----------|-------|-----------|-------|
| **4. Dashboard Vacío** | Primera visita post-login | P0 | Ilustración + "Registra tu primera finca" CTA. Offline-aware. |
| **5. Dashboard con Fincas** | Listado de propiedades | P0 | Cards: Nombre finca, municipio, cultivo principal, badges certificaciones (si existen). |
| **6. Registrar Finca** | Crear finca nueva | P0 | Form: Nombre, municipio/vereda, GPS (manual fallback), cultivo principal, área. Guardar → Vista Finca. |
| **7. Vista Finca** | Ver finca + lotes | P0 | Nombre, mapa/coords, botón "Registrar lote", lista de lotes (vacía inicialmente). |
| **8. Registrar Lote** | Crear lote en finca | P0 | Form: Nombre lote, cultivo, área, foto opcional. Guardar → Vista Lote. |

**Hito:** Agricultor ha creado 1 finca + 1-3 lotes, puede navegar estructura farm/plot.

---

### 📝 **SEMANA 3-4: Activity Logging + Timeline (2 pantallas) — ⭐ CORE MVP**

| Pantalla | Flujo | Prioridad | Notes |
|----------|-------|-----------|-------|
| **9. Vista Lote + Timeline** | Ver lote + historial actividades | **P0 CRÍTICA** | Muestra: Nombre lote, cultivo, área, **timeline vertical de actividades** (vacía inicialmente), 2 botones: "Registrar actividad" + "Generar QR". **Esta es la pantalla más usada en MVP.** |
| **10. Registrar Actividad** | Log activity con foto + notas | **P0 CRÍTICA** | Form dinámico según tipo: Selector tipo (siembra/riego/fertilización/cosecha/otro) → Fecha (pre-filled hoy) → Insumo/dosis → Notas (opcional) → **Botón foto "Tomar evidencia"** → Preview → Guardar. **Debe funcionar 100% offline.** |

**Hito:** Agricultor puede registrar múltiples actividades (siembra, fertilización, etc) con fotos. Timeline se actualiza. Datos se guardanclocalmente sin conexión.

---

### 🔄 **SEMANA 4: Sincronización + Indicadores Offline (Integración WatermelonDB)**

| Feature | Pantalla Afectada | Priority | Notes |
|---------|------------------|----------|-------|
| Sync engine (push/pull) | Todas | P0 | Cuando hay conexión, sincroniza automáticamente. WatermelonDB detecta cambios. |
| Offline indicator | 9, 10 | P0 | Mostrar "📡 Offline" o "🔄 Sincronizando" en header. Critical para transparencia con usuario sin conexión. |
| SMS/USSD alert fallback | Sistema (no pantalla) | Should | Para usuarios R1, R3 (sin smartphone). Alertas por SMS si disponible. |

**Hito:** Sync bidireccional funcionando. Usuario puede trabajar 14+ días sin conexión sin perder datos.

---

### ⚠️ **SEMANA 4-5: Refinamiento UI/UX + Testing**

| Tarea | Pantallas | Priority |
|-------|-----------|----------|
| Activity log UX refinement | 9, 10 | P0 | Asegurar que es "simple como cuaderno". Notebook mental model. SUS score > 60. |
| Offline workflow testing | 6-10 | P0 | Test sin conexión 14+ días. Sync correctness. |
| Photo compression | 8, 10 | P0 | Auto-resize fotos para conexión lenta. |
| Form validation | All forms | P0 | Mensajes amigables, tooltips contextuales. |

**Hito:** Todas las pantallas funcionales, UI pulida, listas para field test.

---

### 🧪 **SEMANA 5-6: Field Test + Launch Prep**

| Actividad | Focus | Expected |
|-----------|-------|----------|
| Field test con 5 farmers | Pantallas 6-10 core usage | 10+ actividades registradas/farmer en 2 semanas sin conexión |
| Bug fixes + refinement | All screens | Zero crashes, <5 sec load time offline |
| Launch checklist | All | API keys, DB migrations, deployment docs ready |

**Hito:** Beta release. MVP listo para pilotar con 1 cooperativa.

---

### 🚫 **QUE NO INCLUYE MVP (Diferido a Phase 2)**

| Screen/Feature | Razón | Phase |
|---|---|---|
| Pantalla 11: Generar QR | Marketplace feature; 0 demand signal | 2 |
| Pantalla 12: QR Fullscreen | Buyer-facing feature | 2 |
| Pantalla 13: Landing pública (comprador) | Requiere buyer validation | 2 |
| Dashboard Cooperativa | B2B feature, deferred | 2 |
| Validación de certificaciones | Requiere partner certificador | 2 |
| Panel Administrador | Phase 2+ (solo auth básica MVP) | 2+ |

---

### 📊 **KPIs MVP (Semana 5 Field Test)**

| Métrica | Target | Criticidad |
|---------|--------|-----------|
| Farmers activos en field test | 5 farmers | MUST |
| Actividades registradas | 10+ por farmer en 2 semanas | MUST |
| Offline resilience | 14+ días sin conexión, 0 data loss | MUST |
| Activity log SUS score | > 60 | MUST |
| Sync correctness | 100%, 0 lost records | MUST |
| Time to register activity | < 3 min (Pantalla 10) | SHOULD |

---

### 📌 **Relación con `01-priorizacion-features-mvp.md`**

Ese documento define **QUÉ features** incluir (MoSCoW: Must/Should/Could/Won't).
**Este documento (Section 7)** define **CUÁNDO y EN QUÉ PANTALLA** construir cada feature.

**Validación cruzada requerida antes de kickoff:**
- ✅ Ambos documentos dicen "10 pantallas MVP" 
- ✅ Ambos dicen "Activity logging + offline + alerts"
- ✅ Ambos defer "QR/marketplace/cooperativa a Phase 2"

**Si hay conflicto, reconciliar AHORA antes de dev kickoff.**

---

**Fin del documento — User Journeys AgriTrace v1.0**

© 2025 Diego Trujillo