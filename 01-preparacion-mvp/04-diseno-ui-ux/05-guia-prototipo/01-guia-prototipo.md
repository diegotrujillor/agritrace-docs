# 💡3.5 Browsable Prototype MVP

# AgriTrace

## 📱 Description

Complete browsable prototype for the **AgriTrace** platform - Traceability and sustainable export system for agricultural producers.

## 📋 Analyzed Documents

The prototype was developed based on:

1. **UI/UX Document (PDF 0-3)**: Branding specifications, color palette, typography and design system
2. **Additional UI/UX (PDF 3.1)**: Information architecture and user flows
3. **Screen Specifications (PDF 3.2)**: Wireframes and detailed specifications for each screen
4. **User Journey Maps (PDF 3.3)**: Journey maps for each user type
5. **Figma JSON**: Prototype structure with transitions

## 🎨 Implemented Design System

### Primary Colors

- Primary Green: `#2D7A3E`
- Dark Green: `#1B5028`
- Light Green: `#E8F5E9`

### Secondary Colors

- Earth Brown: `#6D4C3D`
- Harvest Yellow: `#F9A825`
- Certification Blue: `#1976D2`

### Typography

- Primary: **Inter** (Google Fonts)
- Logo: **Poppins** (Semibold 600)

### Spacing (8px base)

- xs: 4px | sm: 8px | md: 16px | lg: 24px | xl: 32px

## 📱 Included Screens

1. **Splash Screen** - Loading screen with animated logo
2. **Welcome** - Welcome screen with login options
3. **Login** - Sign in
4. **Registration** - Account creation (Step 1/2)
5. **Register Farm** - Farm registration form
6. **Plot View** - Plot visualization with map and activities
7. **Register Activity** - Activity registration form
8. **Generate QR** - Traceability QR code generation
9. **Public Page** - Public traceability view

## 🚀 Generated Files

### Flutter/Dart

- `agritrace_flutter_main.dart` - Main Flutter application code
- `agritrace_pubspec.yaml` - Flutter project configuration

### React/JSX (Visual Prototype)

- `agritrace_prototype.jsx` - Browsable React component

## 💻 Using the Flutter Prototype

### Requirements

- Flutter SDK 3.0.0 or higher
- Dart SDK

### Installation

```
# Crear nuevo proyecto Flutter
flutter create agritrace_app
# Reemplazar lib/main.dart con el archivo proporcionado
cp agritrace_flutter_main.dart agritrace_app/lib/main.dart
# Copiar pubspec.yaml
cp agritrace_pubspec.yaml agritrace_app/pubspec.yaml
# Instalar dependencias
cd agritrace_app
flutter pub get
# Ejecutar
flutter run
```

### Note about fonts

The prototype uses the Inter and Poppins fonts. You can:

1. Download them from Google Fonts
2. Or use the system version (the code will work with fallback fonts)

## 🔄 Navigation Flow

```
Splash → Welcome → Login → Register Finca → Vista Lote
                  ↓
              Registro → Register Finca
                              ↓
                    Vista Lote → Registrar Actividad
                              → Generar QR → Página Pública
```

## ✅ Implemented Features

- [x]  Complete design system with tokens
- [x]  Reusable components (buttons, inputs, cards, badges)
- [x]  Navigation between screens
- [x]  Animations and transitions (300ms ease-in-out)
- [x]  Badge states (active, pending, expired, certified)
- [x]  Offline mode visual indicator (component included)
- [x]  Stylized AgriTrace logo
- [x]  Generated visual QR code
- [x]  Map placeholder with grid pattern
- [x]  Illustrative landscape for public page

## 📐 Dimensions

- Mobile base: 375x812px (iPhone SE reference)
- Mobile-first design
- Responsive ready

## 💻 Source

[https://github.com/diegotrujillor/agritrace-prototype](https://github.com/diegotrujillor/agritrace-prototype)

## 👤 Author

Prototype generated based on specifications by Diego Trujillo (2025)