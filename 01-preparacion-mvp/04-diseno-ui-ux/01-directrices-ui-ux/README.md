# 🖥️ 3. Documento UI/UX

**Insumo maestro para diseño del MVP en Figma**

# **1. 🎨 Branding Visual**

## **1.1 Nombre**

**AgriTrace** — Identidad enfocada en trazabilidad agrícola + sostenibilidad.

## **1.2 Concepto visual**

- Claridad, origen verificable, sostenibilidad.
- UI accesible para zonas rurales.
- Representación gráfica del ciclo del cultivo y su historia.

## **1.3 Paleta de color (UI Tokens)**

### **1.3.1 Colores Primarios**

| **Token** | **HEX** | **RGB** | **Uso** |
| --- | --- | --- | --- |
| Verde primario | `#2D7A3E`  | rgb(45, 122, 62) | Botones principales, headers, elementos de acción |
| Verde oscuro | `#1B5028` | rgb(27, 80, 40) | Fondos, etiquetas,
Texto sobre fondos claros, hover states |
| Verde claro | `#E8F5E9` | rgb(232, 245, 233) | Fondos de tarjetas, estados de éxito |
| neutral/200 | `#F5F5F5` | rgb(245, 245, 245) | Fondos UI |
| neutral/800 | `#3B3B3B` | rgb(59, 59, 59) | Títulos y texto fuerte |

### **1.3.2 Colores Secundarios**

| **Token** | **HEX** | **RGB** | **Uso** |
| --- | --- | --- | --- |
| Café tierra | `#6D4C3D` | rgb(109, 76, 61) | Iconos, elementos complementarios |
| Amarillo cosecha | `#F9A825` | rgb(249, 168, 37) | Alertas importantes, badges, estados "pendiente” |
| Azul certificación | `#1976D2` | rgb(25, 118, 210) | Links, elementos informativos, certificaciones |

### **1.3.3 Colores del Sistema**

| **Token** | **HEX** | **Uso** |
| --- | --- | --- |
| Error | `#D32F2F` | Mensajes de error, validaciones fallidas |
| Warning | `#F57C00` | Advertencias, certificaciones próximas a vencer |
| Success | `#388E3C` | Confirmaciones, sincronización exitosa |
| Info | `#0288D1` | Mensajes informativos, tooltips |

### **1.3.4 Escala de Grises**

| Token | HEX | Uso |
| --- | --- | --- |
| Negro | `#212121` | Títulos, texto principal |
| Gris Oscuro | `#424242` | Texto secundario |
| Gris Medio | `#757575` | Texto terciario, placeholders |
| Gris Claro | `#E0E0E0` | Bordes, divisores |
| Gris Muy Claro | `#F5F5F5` | Fondos de página |
| Blanco | `#FFFFFF` | Fondos de tarjetas, modales |

## 1.4 Tipografía

### **1.4.1 Fuente Principal**

**Inter** (Google Fonts)

- Moderna, legible en pantallas móviles
- Excelente para interfaces digitales
- Soporte completo de caracteres latinos

**Jerarquía:**

`H1: Inter Bold - 32px / 40px line-height
H2: Inter Semibold - 24px / 32px line-height
H3: Inter Semibold - 20px / 28px line-height
H4: Inter Medium - 18px / 26px line-height
Body Large: Inter Regular - 16px / 24px line-height
Body: Inter Regular - 14px / 22px line-height
Small: Inter Regular - 12px / 18px line-height
Button: Inter Medium - 14px / 20px line-height`

### **1.4.2 Fuente Secundaria (Opcional)**

**Poppins** (Google Fonts) - Solo para logotipo y landing page

- Peso: 600 (Semibold)

### **1.4.3 Estilo UI**

- Minimalista
- Íconos outline (Material Icons or Feather Icons)
- Alto contraste para visibilidad bajo sol
- Accesibilidad: botones grandes, textos ≥ 16px

# **2. 🧩 Sistema de Diseño (Design System Base)**

## **2.1 Botones**

Botón Primario:

- Fondo: Verde Primario `#2D7A3E`
- Texto: Blanco `#FFFFFF`
- Border-radius: `8px`
- Padding: `12px 24px`
- Sombra: `0 2px 4px rgba(0,0,0,0.1)`
- Hover: Verde Oscuro `#1B5028`

Botón Secundario:

- Fondo: Blanco `#FFFFFF`
- Texto: Verde Primario `#2D7A3E`
- Border: `1px solid #2D7A3E`
- Border-radius: `8px`
- Padding: `12px 24px`
- Hover: Fondo Verde Claro `#E8F5E9`

Botón Terciario (Text):

- Sin fondo
- Texto: Verde Primario `#2D7A3E`
- Hover: Subrayado

## **2.2 Inputs y Formularios**

Input Field:

- Border: `1px solid #E0E0E0`
- Border-radius: `8px`
- Padding: `12px 16px`
- Focus: Border Azul `#1976D2`, shadow `0 0 0 3px rgba(25,118,210,0.1)`
- Error: Border Rojo `#D32F2F`

Label:

- Color: Gris Oscuro `#424242`
- Peso: Inter Medium
- Tamaño: 14px
- Margin-bottom: 8px

## **2.3 Tarjetas (Cards)**

Card Estándar:

- Fondo: Blanco `#FFFFFF`
- Border: `1px solid #E0E0E0`
- Border-radius: `12px`
- Padding: `20px`
- Sombra: `0 2px 8px rgba(0,0,0,0.08)`
- Hover: Sombra `0 4px 12px rgba(0,0,0,0.12)`

## **2.4 Iconografía**

Librería: Lucide Icons (React)

- Consistencia visual
- Variedad de íconos agrícolas
- Ligero y optimizado

Tamaños estándar:

- Small: 16px
- Medium: 20px
- Large: 24px
- Extra Large: 32px

Color por defecto: Gris Oscuro `#424242`

## **2.5 Código QR**

Contenedor del QR:

- Padding: `24px`
- Fondo: Blanco
- Border-radius: `12px`
- Sombra: `0 4px 12px rgba(0,0,0,0.15)`

Logo central: Icono de AgriTrace

- Tamaño: 15% del QR
- Fondo circular blanco

## **2.6 Estados y Badges**

Badge de Estado:

`Activo: Fondo #E8F5E9, Texto #2D7A3E
Pendiente: Fondo #FFF8E1, Texto #F9A825
Vencido: Fondo #FFEBEE, Texto #D32F2F
Certificado: Fondo #E3F2FD, Texto #1976D2`

- Border-radius: `16px`
- Padding: `4px 12px`
- Tamaño de fuente: 12px
- Peso: Inter Medium

## **2.7 Componentes Clave**

- Timeline vertical de actividades
- Mapa/ubicación (estático o imagen)
- Tarjetas de lotes
- Vista QR fullscreen
- Listas de certificaciones (estado: activo, pendiente, vencida, aprobada/certificada, rechazada)

# 3. 📐 ****Layout y Espaciado

## **3.1 Sistema de Espaciado (8px base)**

`xs: 4px
sm: 8px
md: 16px
lg: 24px
xl: 32px
2xl: 48px
3xl: 64px`

## **3.2 Grid y Breakpoints**

Mobile First:

`Mobile: < 640px (1 columna)
Tablet: 640px - 1024px (2 columnas)
Desktop: > 1024px (3-4 columnas)`

## **3.3 Márgenes de Página**

- Mobile: `16px`
- Tablet: `24px`
- Desktop: `40px`

# 4. ✨ ****Animaciones y Transiciones

## 4.1 Principios

- **Duración estándar:** 200ms
- **Easing:** `ease-in-out`
- **Hover:** 150ms
- **Modal/Dialog:** 300ms con fade-in

## 4.2 Efectos Comunes

`/* Hover en botones */
transition: all 0.2s ease-in-out;`

`/* Aparición de tarjetas */
animation: fadeIn 0.3s ease-in-out;`

`/* Loading spinner */
animation: rotate 1s linear infinite;`

# 5. 📡 ****Modo Offline

## 5.1 Indicador Visual

**Barra superior:**

- Fondo: Amarillo `#FFF8E1`
- Texto: Negro `#212121`
- Icono: Cloud-off
- Mensaje: "Modo sin conexión - Los datos se sincronizarán automáticamente cuando el app esté en línea"

## 5.2 Elementos Deshabilitados

- Opacidad: 0.5
- Cursor: `not-allowed`
- Tooltip explicativo

# 6. ♿ ****Accesibilidad (WCAG 2.1 AA)

## 6.1 Contraste

- Texto principal sobre blanco: Mínimo 4.5:1
- Texto grande (18px+): Mínimo 3:1
- Elementos interactivos: Mínimo 3:1

## 6.2 Focus States

- Outline: `2px solid #1976D2`
- Offset: `2px`
- Border-radius: heredado del elemento

## 6.3 Touch Targets

- Tamaño mínimo: 44x44px (mobile)
- Espaciado entre elementos táctiles: 8px mínimo

# 7. 🖌️ ****Recursos de Diseño

## 7.1 Assets Requeridos

- [ ]  Logotipo (SVG, PNG 1x 2x 3x)
- [ ]  Favicon (ICO, PNG)
- [ ]  Iconos personalizados (agricultura específicos)
- [ ]  Ilustraciones para empty states
- [ ]  Imágenes de placeholder (fincas, cultivos)

## 7.2 Exportación de Componentes

- Formato: SVG para iconos
- PNG @2x y @3x para imágenes
- WebP para web performance

# 8. 📱 ****Ejemplos de Pantallas Clave

## 8.1 Login

- Fondo: Imagen de cultivo con overlay Verde Primario (opacity 0.85)
- Card central: Blanco, border-radius 16px
- Logo centrado superior
- Formulario minimalista

## 8.2 Dashboard Productor

- Header: Verde Primario con nombre de usuario
- Tarjetas de resumen: Grid 2x2 (mobile: 1x4)
- Lista de fincas: Cards con imagen, nombre, estado
- FAB inferior derecho: "+" para nueva finca

## 8.3 Registro de Actividad

- Header con título de lote
- Timeline vertical a la izquierda
- Formulario con campos progresivos
- Botón de cámara destacado
- Preview de imágenes en grid

## 8.4 Vista Pública QR

- Hero con imagen del lote
- Badge de certificación destacado
- Timeline de trazabilidad
- Footer con logo AgriTrace y "Verificado por"

# 9. 🖼️ **Mockups (solo a modo de ejemplo)**

> 📐 *Imagen de directrices UI/UX disponible en [agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)*

[🔗 3.1 UI/IX (adicionales)](%F0%9F%96%A5%EF%B8%8F%203%20Documento%20UI%20UX/%F0%9F%94%97%203%201%20UI%20IX%20(adicionales)%202af25cc7465f80debda1e8e4e8e03ac3.md)

[🖼️ 3.2 Especificaciones de Pantallas para Figma](%F0%9F%96%A5%EF%B8%8F%203%20Documento%20UI%20UX/%F0%9F%96%BC%EF%B8%8F%203%202%20Especificaciones%20de%20Pantallas%20para%20Figma%202af25cc7465f80d292dbe6c309a76601.md)

[🛣️ 3.3 User Journey Maps y Flujos de Usuario](%F0%9F%96%A5%EF%B8%8F%203%20Documento%20UI%20UX/%F0%9F%9B%A3%EF%B8%8F%203%203%20User%20Journey%20Maps%20y%20Flujos%20de%20Usuario%202af25cc7465f80eeb6d2ef46ea26e212.md)

[🌱 3.4 Platform Design](%F0%9F%96%A5%EF%B8%8F%203%20Documento%20UI%20UX/%F0%9F%8C%B1%203%204%20Platform%20Design%202b425cc7465f80d2a237d13c43c8ccca.md)

[💡3.5 Browsable Prototype MVP](%F0%9F%96%A5%EF%B8%8F%203%20Documento%20UI%20UX/%F0%9F%92%A13%205%20Browsable%20Prototype%20MVP%202b625cc7465f8076ad93e5870e5266d4.md)