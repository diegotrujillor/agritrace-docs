# 🔗 3.1 UI/IX (adicionales)

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
    - Generar QR

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

## **A8 – Generar QR**

- Mostrar resumen del lote
- Certificaciones asociadas (si existen)
- Botón: **Generar QR**
- Vista QR fullscreen
- Botones: Descargar / Compartir

---

## **2.2 FLOW B — Cooperativa (validación)**

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

## **2.3 FLOW C — Exportador / Comprador (público, sin login)**

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

Esta pantalla es clave para comercio internacional.

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

### **Pantalla 9 — Vista del Lote**

- Info del lote
- Timeline vertical
- Botones:
    - Registrar actividad
    - Generar QR

### **Pantalla 10 — Registrar actividad**

Formulario dinámico

---

## **3.5 Trazabilidad y QR**

### **Pantalla 11 — Generar QR**

- Resumen
- Botón: Generar QR

### **Pantalla 12 — QR Fullscreen**

- QR grande
- Botones: Descargar / Compartir

---

## **3.6 Página pública QR (web móvil)**

### **Pantalla 13 — Trazabilidad completa**

- Productor
- Finca
- Lote
- Actividades
- Fotos
- Certificaciones
- Botón PDF

# **4. 📏 Reglas de UX y microinteracciones**

- Confirmaciones por snackbars (esquinas inferiores).
- Indicador de sincronización cuando no hay red.
- Carga de imágenes con preview instantánea.
- Colapsar timeline cuando es extenso.
- QR con bordes amplios y contraste alto.