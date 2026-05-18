# Marca AgriTrace

Activos oficiales de marca. Fuente canónica del logo.

## Origen

El logo se extrajo fielmente del componente `AgriTraceLogo` codificado en
el prototipo navegable (`agritrace-demo/src/agritrace_prototype.jsx`), que
es donde la marca existía únicamente como JSX/SVG inline. Estos archivos
lo convierten en activos reutilizables y versionados.

## Concepto

- **Hoja** (verde primario) — agricultura.
- **Lupa** en badge inferior-derecho — trazabilidad / verificación.
- Círculo de fondo verde claro.
- Wordmark "AgriTrace" en Poppins SemiBold.

## Archivos

| Archivo | Uso |
|---|---|
| `agritrace-logo-mark.svg` | Solo ícono (256×256). App, avatares, espacios cuadrados. |
| `agritrace-logo-lockup.svg` | Ícono + wordmark vertical. Splash, headers, documentos. |
| `favicon.svg` | Variante simplificada para 16–32 px (pestaña de navegador, PWA). |

## Paleta (design tokens)

| Token | Hex | Uso |
|---|---|---|
| `verdePrimario` | `#2D7A3E` | Hoja, badge, wordmark |
| `verdeClaro` | `#E8F5E9` | Fondo del círculo |
| `blanco` | `#FFFFFF` | Lupa |

Paleta completa: `agritrace-demo/src/agritrace_prototype.jsx` (DESIGN TOKENS).

## Notas

- Tipografía: **Poppins SemiBold** (600). Incluir la webfont donde se use
  el lockup; hay fallback a sans-serif del sistema.
- Geometría de hoja y lupa derivada de iconos **lucide** (licencia ISC).
- SVG escalable sin pérdida; no exportar a PNG salvo que la plataforma lo
  exija (p. ej. iconos de app nativa).
