# Guía de Estructura del Repositorio - AgriTrace Docs

## Descripción General

Este documento define la estructura organizada del repositorio de documentación de AgriTrace. Todos los archivos están organizados por fase y orden de lectura, con nombres en español y prefijos numéricos que indican la secuencia.

## Estructura a Nivel Raíz

```
agritrace-docs/
├── README.md                           (Índice principal)
├── 00-referencia/                      (Documentos de referencia)
├── 01-preparacion-mvp/                 (Fase 1: Preparación del MVP)
├── 02-documentacion-tecnica/           (Documentación Técnica)
└── 03-recursos/                        (Recursos compartidos e imágenes)
```

## Fase 1: Preparación del MVP (`01-preparacion-mvp/`)

Cubre análisis, diseño, arquitectura, infraestructura y gestión de proyectos para el MVP.

```
01-preparacion-mvp/
├── README.md
├── 01-encuesta-partes-interesadas/
│   ├── README.md
│   └── 01-encuesta-partes-interesadas.md
├── 02-requerimientos-funcionales/
│   ├── README.md
│   ├── 01-requerimientos-funcionales.md
│   └── 02-requerimientos-no-funcionales.md
├── 03-mapeo-funcional/
│   ├── README.md
│   └── 01-mapeo-funcional.md
├── 04-diseno-ui-ux/
│   ├── README.md
│   ├── 01-directrices-ui-ux/
│   │   ├── README.md
│   │   └── 01-directrices-ui-ux.md
│   ├── 02-especificaciones-pantallas/
│   │   ├── README.md
│   │   ├── 01-especificaciones-pantallas.md
│   │   └── 02-especificaciones-figma.md
│   ├── 03-mapas-recorrido-usuario/
│   │   ├── README.md
│   │   └── 01-mapas-recorrido-usuario.md
│   ├── 04-diseno-plataforma/
│   │   ├── README.md
│   │   └── 01-diseno-plataforma.md
│   └── 05-guia-prototipo/
│       ├── README.md
│       └── 01-guia-prototipo.md
├── 05-arquitectura-tecnica/
│   ├── README.md
│   ├── 01-resumen-arquitectura.md
│   ├── 02-diseno-base-de-datos.md
│   ├── 03-flujo-datos.md
│   └── 04-stack-tecnologico.md
├── 06-infraestructura/
│   ├── README.md
│   ├── 01-configuracion-infraestructura.md
│   ├── 02-configuracion-dns-dominio.md
│   ├── 03-configuracion-docker.md
│   ├── 04-configuracion-base-de-datos.md
│   └── 05-respaldo-monitoreo.md
├── 07-gestion-de-proyectos/
│   ├── README.md
│   ├── 01-hoja-ruta-proyecto.md
│   ├── 02-backlog-producto.md
│   ├── 03-panel-kpis.md
│   └── 04-cronograma-hitos.md
└── 08-presupuesto-inversion/
    ├── README.md
    └── 01-control-presupuesto.md
```

## Documentación Técnica (`02-documentacion-tecnica/`)

Especificaciones técnicas detalladas y guías de implementación.

```
02-documentacion-tecnica/
├── README.md
├── 01-analisis/
│   ├── README.md
│   └── 01-analisis-completo.md
├── 02-base-de-datos/
│   ├── README.md
│   ├── 01-diseno-base-de-datos.md
│   └── 02-modelos-datos.md
├── 03-api/
│   ├── README.md
│   ├── 01-especificacion-openapi.yaml
│   └── 02-directrices-api.md
├── 04-desarrollo/
│   ├── README.md
│   └── 01-directrices-desarrollo.md
├── 05-documentacion/
│   ├── README.md
│   └── 01-guia-documentacion.md
└── 06-deployment/
    ├── README.md
    └── 01-guia-despliegue.md
```

## Recursos (`03-recursos/`)

Recursos compartidos, diagramas, imágenes e iconografía.

```
03-recursos/
└── (Contenido de recursos de diseño y diagramas)
```

## Convenciones de Nombres

### Carpetas
- **Nombres en español**: Todos los nombres de carpeta están en español
- **Minúsculas con guiones**: ej. `01-preparacion-mvp`, `02-base-de-datos`
- **Numeración secuencial**: Prefijos 01-, 02-, 03-, etc. indican orden de lectura
- **Sin emojis en nombres**: Los emojis solo se usan en encabezados para organización visual

### Archivos
- **Nombres en español**: Todos los nombres de archivo están en español
- **Minúsculas con guiones**: ej. `01-requerimientos-funcionales.md`
- **Numeración secuencial**: Indica orden de lectura dentro de la carpeta
- **README.md para navegación**: Cada carpeta importante tiene un README.md que explica contenido

## Patrones de Navegación

### Archivos README.md
Cada carpeta importante contiene un `README.md` que:
- Explica el propósito de la carpeta
- Lista subsecciones numeradas
- Proporciona orden de lectura recomendado
- Incluye referencias cruzadas a secciones relacionadas

### Referencias Cruzadas
Los archivos incluyen referencias a:
- Carpetas relacionadas en la misma fase
- Otras fases del proyecto
- Documentación técnica
- Recursos compartidos

## Orden de Lectura Recomendado

### Para Stakeholders de Negocio
1. [README.md](../README.md) → Descripción General
2. [01-preparacion-mvp/README.md](../01-preparacion-mvp/README.md) → Fase 1 MVP
3. [01-preparacion-mvp/02-requerimientos-funcionales/](../01-preparacion-mvp/02-requerimientos-funcionales/) → Requerimientos
4. [01-preparacion-mvp/07-gestion-de-proyectos/](../01-preparacion-mvp/07-gestion-de-proyectos/) → Cronograma y Roadmap

### Para Diseñadores
1. [README.md](../README.md) → Descripción General
2. [01-preparacion-mvp/04-diseno-ui-ux/README.md](../01-preparacion-mvp/04-diseno-ui-ux/README.md) → Diseño UI/UX
3. [01-preparacion-mvp/04-diseno-ui-ux/01-directrices-ui-ux/](../01-preparacion-mvp/04-diseno-ui-ux/01-directrices-ui-ux/) → Directrices
4. [01-preparacion-mvp/04-diseno-ui-ux/05-guia-prototipo/](../01-preparacion-mvp/04-diseno-ui-ux/05-guia-prototipo/) → Prototipo

### Para Desarrolladores
1. [README.md](../README.md) → Descripción General
2. [02-documentacion-tecnica/README.md](../02-documentacion-tecnica/README.md) → Documentación Técnica
3. [02-documentacion-tecnica/02-base-de-datos/](../02-documentacion-tecnica/02-base-de-datos/) → Base de Datos
4. [02-documentacion-tecnica/03-api/](../02-documentacion-tecnica/03-api/) → API
5. [01-preparacion-mvp/05-arquitectura-tecnica/](../01-preparacion-mvp/05-arquitectura-tecnica/) → Arquitectura

### Para Gestores de Proyectos
1. [README.md](../README.md) → Descripción General
2. [01-preparacion-mvp/README.md](../01-preparacion-mvp/README.md) → Fase 1 MVP
3. [01-preparacion-mvp/07-gestion-de-proyectos/](../01-preparacion-mvp/07-gestion-de-proyectos/) → Gestión de Proyectos
4. [01-preparacion-mvp/08-presupuesto-inversion/](../01-preparacion-mvp/08-presupuesto-inversion/) → Presupuesto

## Notas Importantes

- **Archivos Deprecados**: El archivo `02-documentacion-tecnica/00-guia-estructura-repositorio.md` está deprecado. Ver este archivo en `00-referencia/01-guia-estructura-repositorio.md` en su lugar.
- **Nombres Españoles**: Toda la documentación está en español desde Mayo 2026
- **Git History**: Todos los archivos movidos preservan su historial de git completo

## Contribuyendo

Al agregar nueva documentación:

1. Coloca el contenido en la fase o sección técnica apropiada
2. Utiliza nombres en español en minúsculas con guiones
3. Añade prefijos numéricos para indicar orden de lectura
4. Crea o actualiza archivos README.md para nuevas secciones
5. Actualiza el README.md principal si agregas secciones importantes
6. Sigue la estructura y patrones definidos en esta guía

---

**Última Actualización**: Mayo 2026  
**Versión**: 2.0 (Spanish)
