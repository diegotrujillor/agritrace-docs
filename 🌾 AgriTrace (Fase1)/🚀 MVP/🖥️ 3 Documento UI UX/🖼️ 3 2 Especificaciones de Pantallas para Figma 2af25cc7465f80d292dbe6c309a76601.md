# 🖼️ 3.2 Especificaciones de Pantallas para Figma

**Versión:** 1.0 - MVP

**Plataforma:** Mobile-first (iOS y Android)

**Resoluciones base:**

- Mobile: 375x812px (iPhone SE referencia)
- Tablet: 768x1024px
- Desktop: 1440x900px

---

## 📋 Índice de Pantallas

### Flujo de Autenticación

1. Splash Screen
2. Onboarding (3 slides)
3. Login
4. Registro

### Flujo Productor

1. Dashboard Productor
2. Registro de Finca
3. Mapa de Ubicación
4. Registro de Lotes
5. Detalle de Lote
6. Registro de Actividad
7. Timeline de Actividades
8. Generación de QR
9. Compartir QR

### Flujo Cooperativa

1. Dashboard Cooperativa
2. Lista de Productores
3. Validación de Certificaciones
4. Detalle de Productor

### Flujo Público

1. Landing Trazabilidad (QR Scan)
2. Timeline Público
3. Certificaciones

### Flujo Administrador

1. Dashboard Admin
2. Gestión de Usuarios
3. Logs de Auditoría

---

## 🎨 Configuración de Figma

### Frames y Auto-layout

- **Mobile:** Frame 375x812px
- **Componentes:** Usar auto-layout para responsive
- **Spacing:** Sistema 8px base
- **Padding estándar:** 16px (mobile), 24px (tablet/desktop)

### Plugins recomendados

- **Unsplash:** Fotos de fincas/cultivos
- **Iconify:** Librería Lucide Icons
- **Content Reel:** Datos de prueba
- **Stark:** Validación de accesibilidad

---

## 📱 Pantallas Detalladas

---

### 1. SPLASH SCREEN

**Dimensiones:** 375x812px

**Elementos:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image.png)

**Colores:**

- Fondo: Blanco `#FFFFFF`
- Logo: Verde Primario `#2D7A3E`
- Texto secundario: Gris Medio `#757575`

**Duración:** 2 segundos → Auto-avanza a Onboarding (primera vez) o Login

---

### 2. ONBOARDING (Slide 1/3)

**Elementos:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%201.png)

**Slide 2/3:** "Genera códigos QR" + ilustración de QR
**Slide 3/3:** "Accede a mercados premium" + ilustración de exportación

**Interacciones:**

- Swipe horizontal entre slides
- "Omitir" lleva a Login
- "Siguiente" (Slide 3) → "Comenzar" lleva a Registro

---

### 3. LOGIN

**Elementos:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%202.png)

**Validaciones:**

- Email/celular: formato válido
- Contraseña: mínimo 8 caracteres
- Error message: aparece debajo del campo con color rojo

---

### 4. REGISTRO

**Estructura:** Formulario de 2 pasos

**Paso 1/2:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%203.png)

**Paso 2/2:** Contraseña, confirmar contraseña, términos y condiciones

---

### 5. DASHBOARD PRODUCTOR

**Componentes principales:**

**Header:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%204.png)

**Tarjetas de resumen:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%205.png)

**Lista de fincas:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%206.png)

**FAB (Floating Action Button):**

- Posición: Esquina inferior derecha
- Icono: [+] blanco
- Color: Verde Primario
- Sombra: elevation-6
- Al tocar: Modal de opciones
    - "Nueva finca"
    - "Nuevo lote"
    - "Registrar actividad"

---

### 6. REGISTRO DE FINCA

**Layout:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%207.png)

**Paso 2:** Ubicación (mapa interactivo)
**Paso 3:** Certificaciones disponibles (opcional)

---

### 7. MAPA DE UBICACIÓN

**Componentes:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%208.png)

**Interacciones:**

- Drag del pin actualiza coordenadas
- Búsqueda por dirección
- Botón "Mi ubicación" para GPS automático

---

### 8. REGISTRO DE LOTES

**Layout:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%209.png)

**Modal "Nuevo lote":**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%2010.png)

---

### 9. DETALLE DE LOTE

**Header con imagen:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%2011.png)

**Tabs de navegación:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%2012.png)

---

### 10. REGISTRO DE ACTIVIDAD

**Selector de tipo (Paso 1):**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%2013.png)

**Formulario (Paso 2 - Ejemplo: Fertilización):**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%2014.png)

---

### 11. TIMELINE DE ACTIVIDADES

**Layout:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%2015.png)

**Card expandida:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%2016.png)

---

### 12. GENERACIÓN DE QR

**Pantalla principal:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%2017.png)

---

### 13. COMPARTIR QR

**Bottom sheet:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%2018.png)

---

### 14. DASHBOARD COOPERATIVA

**Header:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%2019.png)

**Tabs:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%2020.png)

---

### 15. VALIDACIÓN DE CERTIFICACIONES

**Pantalla de revisión:**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%2021.png)

---

### 18. LANDING TRAZABILIDAD (QR SCAN)

**Vista pública (web responsive):**

![image.png](%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma/image%2022.png)