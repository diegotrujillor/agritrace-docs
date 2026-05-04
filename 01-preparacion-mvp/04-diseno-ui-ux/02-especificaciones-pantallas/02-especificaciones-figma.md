# 🖼️ 3.2 Especificaciones de Pantallas para Figma

**Versión:** 1.0 - MVP

**Plataforma:** Mobile únicamente (iOS y Android — sin web, sin desktop)

**Resoluciones base:**

- Mobile: 375x812px (iPhone SE referencia)
- Tablet: 768x1024px

> 📱 **Nota sobre imágenes:** Los mockups de cada pantalla están disponibles en el repositorio del prototipo: **[agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)**. Las imágenes referenciadas abajo provienen de exportaciones de Notion y no están disponibles localmente — ver el repo del prototipo para capturas actualizadas.

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

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

**Colores:**

- Fondo: Blanco `#FFFFFF`
- Logo: Verde Primario `#2D7A3E`
- Texto secundario: Gris Medio `#757575`

**Duración:** 2 segundos → Auto-avanza a Onboarding (primera vez) o Login

---

### 2. ONBOARDING (Slide 1/3)

**Elementos:**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

**Slide 2/3:** "Genera códigos QR" + ilustración de QR
**Slide 3/3:** "Accede a mercados premium" + ilustración de exportación

**Interacciones:**

- Swipe horizontal entre slides
- "Omitir" lleva a Login
- "Siguiente" (Slide 3) → "Comenzar" lleva a Registro

---

### 3. LOGIN

**Elementos:**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

**Validaciones:**

- Email/celular: formato válido
- Contraseña: mínimo 8 caracteres
- Error message: aparece debajo del campo con color rojo

---

### 4. REGISTRO

**Estructura:** Formulario de 2 pasos

**Paso 1/2:**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

**Paso 2/2:** Contraseña, confirmar contraseña, términos y condiciones

---

### 5. DASHBOARD PRODUCTOR

**Componentes principales:**

**Header:**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

**Tarjetas de resumen:**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

**Lista de fincas:**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

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

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

**Paso 2:** Ubicación (mapa interactivo)
**Paso 3:** Certificaciones disponibles (opcional)

---

### 7. MAPA DE UBICACIÓN

**Componentes:**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

**Interacciones:**

- Drag del pin actualiza coordenadas
- Búsqueda por dirección
- Botón "Mi ubicación" para GPS automático

---

### 8. REGISTRO DE LOTES

**Layout:**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

**Modal "Nuevo lote":**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

---

### 9. DETALLE DE LOTE

**Header con imagen:**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

**Tabs de navegación:**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

---

### 10. REGISTRO DE ACTIVIDAD

**Selector de tipo (Paso 1):**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

**Formulario (Paso 2 - Ejemplo: Fertilización):**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

---

### 11. TIMELINE DE ACTIVIDADES

**Layout:**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

**Card expandida:**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

---

### 12. GENERACIÓN DE QR

**Pantalla principal:**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

---

### 13. COMPARTIR QR

**Bottom sheet:**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

---

### 14. DASHBOARD COOPERATIVA

**Header:**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

**Tabs:**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

---

### 15. VALIDACIÓN DE CERTIFICACIONES

**Pantalla de revisión:**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

---

### 18. LANDING TRAZABILIDAD (QR SCAN)

**Vista pública (web responsive):**

> 📱 *Captura disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*