# 🔗 3.1 UI/IX (adicionales)

**Versión:** 1.1 (alineada con [`../../09-scope-mvp.md`](../../09-scope-mvp.md) — Mayo 2026)

> ⚠️ **Alcance MVP**: solo se implementan las **10 pantallas** del Flow A (Productor), Pantallas 1-10 de la sección 3. Las pantallas A8 / 11 / 12 / 13 (QR y página pública), el Flow B (Cooperativa) y el Flow C (Exportador / Comprador) quedan documentados aquí únicamente como referencia de **iteración futura**. Fuente: [`../../09-scope-mvp.md`](../../09-scope-mvp.md) §3.

# **1. 🧭 Arquitectura de Información (IA)**

> 📐 *Diagrama de arquitectura de información disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

# **2. 🗺️ Recorridos de Usuario Completos (User Flows)**

Estos son los flujos **lineales y explícitos** que deben traducirse en prototipos en Figma.

## **2.1 FLOW A — Productor (principal en el MVP)**

### **A0 – Onboarding**

1. Usuario abre la app → Pantalla de bienvenida
2. Ver botones: “Ingresar” y “Crear cuenta”

### **A1 – Crear cuenta**

1. Selecciona Rol = “Productor”
2. Ingresar datos:
    - nombre completo
    - teléfono
    - email
    - contraseña
3. Confirmar → Ir a Dashboard vacío

---

## **A2 – Dashboard inicial (sin fincas)**

Elementos:

- Estado vacío: “Aún no has registrado una finca”
- Botón principal: **Registrar Finca**

---

## **A3 – Registrar Finca**

Inputs:

- Nombre de la finca
- Municipio / vereda
- Coordenadas (botón “Obtener ubicación”)
- Cultivo principal
    
    Botón → **Guardar**
    

Resultado → Vista de finca.

---

## **A4 – Vista de Finca**

Componentes:

- Nombre finca
- Mapa/Coordenadas
- Lista de lotes (inicialmente vacío)
- Botón **Registrar Lote**

---

## **A5 – Registrar Lote**

Campos:

- Nombre lote
- Cultivo
- Área
- Foto opcional
    
    → Guardar
    

---

## **A6 – Vista del Lote**

Componentes:

- Cultivo
- Info básica
- Timeline de actividades
- Botones:
    - Registrar actividad
    - Exportar PDF de trazabilidad
    - ~~Generar QR~~ **(iteración futura — no MVP)**

---

## **A7 – Registrar Actividad**

Campos según tipo:

- Tipo (siembra, fertilización, cosecha, etc.)
- Fecha
- Fotos (máx 3)
- Notas
    
    → Guardar
    

El usuario podría registrar múltiples actividades.

---

## **A8 – Generar QR** — ⏸️ Iteración futura (no MVP)

> Pantalla documentada para roadmap; **no se implementa en MVP**. Razón: scope-mvp.md §4 difiere QR público a iteración futura (cero demanda firme en encuesta de stakeholders).

- Mostrar resumen del lote
- Certificaciones asociadas (si existen)
- Botón: **Generar QR**
- Vista QR fullscreen
- Botones: Descargar / Compartir

---

## **2.2 FLOW B — Cooperativa (validación)** — ⏸️ Iteración futura (no MVP)

> Flow completo documentado para roadmap; **no se implementa en MVP**. Razón: scope-mvp.md §4 difiere dashboard de cooperativa.

### **B1 – Login**

Rol: Cooperativa

### **B2 – Dashboard**

- Productores
- Certificaciones pendientes
- Filtro por estado

### **B3 – Validación de certificación**

- Ver PDF
- Estado actual
- Botones: Aprobar / Rechazar
- Notificación automática al productor

---

## **2.3 FLOW C — Exportador / Comprador (público, sin login)** — ⏸️ Iteración futura (no MVP)

> Flow documentado para roadmap; **no se implementa en MVP**. Razón: scope-mvp.md §4 difiere consulta pública por QR (cero respondentes compradores en encuesta).

### **C1 – Escanear QR (fuera de la app)**

Abre URL pública.

### **C2 – Página pública de trazabilidad**

Incluye:

- Información del productor
- Finca
- Lote y actividades
- Fotos del cultivo
- Certificaciones
- Botón descargar certificado PDF

Esta pantalla es clave para comercio internacional **en iteración futura**, una vez validada la adopción del productor en MVP.

# **3. 📱 Pantallas del MVP (para Figma)**

Lista completa con estructura, elementos visuales y funcionalidades. Estas descripciones son *directamente traducibles a frames en Figma*.

## **3.1 Autenticación**

### **Pantalla 1 — Bienvenida**

Elementos:

- Logo AgriTrace
- Texto corto
- Img ilustrativa (opcional)
- Botón: “Ingresar”
- Botón: “Crear cuenta”

### **Pantalla 2 — Registro**

Inputs:

- Nombre
- Email
- Teléfono
- Contraseña
- Selector de Rol
    
    Botón principal: Crear cuenta
    

### **Pantalla 3 — Login**

- Email
- Contraseña
- Link para recuperar contraseña

---

## **3.2 Dashboard Productor**

### **Pantalla 4 — Dashboard vacío**

- Ilustración / icono
- Texto: “Aún no has registrado una finca”
- Botón: Registrar finca

### **Pantalla 5 — Dashboard con fincas**

Lista tipo tarjetas:

- Nombre
- Municipio
- Cultivo principal
- Badge de certificaciones (si existen)

---

## **3.3 Fincas y Lotes**

### **Pantalla 6 — Registrar finca**

Formulario + GPS button

### **Pantalla 7 — Vista Finca**

- Nombre
- Mapa/coordenadas
- Botón: Registrar lote
- Lista de lotes

### **Pantalla 8 — Registrar lote**

Campos + foto opcional

---

## **3.4 Actividades**

### **Pantalla 9 — Vista del Lote** ⭐ *(pantalla más importante del MVP)*

- Info del lote
- Timeline vertical de actividades
- Botones:
    - Registrar actividad
    - Exportar PDF de trazabilidad
    - ~~Generar QR~~ **(iteración futura — no MVP)**

### **Pantalla 10 — Registrar actividad**

Formulario dinámico (tipo, fecha, fotos, notas).

---

## **3.5 Trazabilidad y QR** — ⏸️ Iteración futura (no MVP)

> Pantallas 11-13 documentadas para roadmap; **no se implementan en MVP**. Razón: scope-mvp.md §4 difiere QR público y página pública de trazabilidad.

### **Pantalla 11 — Generar QR** *(iteración futura)*

- Resumen
- Botón: Generar QR

### **Pantalla 12 — QR Fullscreen** *(iteración futura)*

- QR grande
- Botones: Descargar / Compartir

---

## **3.6 Página pública QR (web móvil)** — ⏸️ Iteración futura (no MVP)

### **Pantalla 13 — Trazabilidad completa** *(iteración futura)*

- Productor
- Finca
- Lote
- Actividades
- Fotos
- Certificaciones
- Botón PDF

# **4. 📏 Reglas de UX y microinteracciones**

- Confirmaciones por snackbars (esquinas inferiores).
- Indicador de sincronización cuando no hay red (estado: offline / sincronizando / sincronizado).
- Carga de imágenes con preview instantánea + compresión local.
- Colapsar timeline cuando es extenso.
- Auto-guardado local en cada paso (offline-first).
- Botón "Exportar PDF" visible en vista de lote (Pantalla 9).