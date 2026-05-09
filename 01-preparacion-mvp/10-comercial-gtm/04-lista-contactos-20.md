# 04 - Lista de Contactos: 20 prospectos específicos (Valle del Cauca)

**Objetivo**: identificar 20 prospectos reales y específicos en Valle del Cauca antes de iniciar las llamadas de validación. No "pequeños productores genéricos": personas con nombre, teléfono, email.

**Tiempo estimado**: 4-6 horas distribuidas a lo largo de Semana 1.

---

## Estructura: 20 contactos = 4 fuentes × 5 contactos

| Fuente | Cantidad | Quién busca | Tiempo estimado |
|--------|----------|-------------|------------------|
| Cooperativas (Google Maps, Confecámaras) | 5 | Diego | 1.5 h |
| Grupos Facebook / WhatsApp de productores | 5 | Esposa | 1 h |
| Confecámaras Valle del Cauca (productores formalizados) | 5 | Diego | 1 h |
| Gremios / Instituciones (refieren contactos) | 5 | Diego | 1.5 h |

---

## Fuente 1: Cooperativas y Asociaciones (Valle del Cauca)

**Cómo buscar**:

1. Google Maps: `"Cooperativas productores Valle del Cauca"`, `"Asociación cacaocultores Valle"`, `"ASOPROCAÑA"`, `"ASOHORTICULTORES Valle"`, `"Cooperativa cafetera Valle"`
2. Confecámaras Valle del Cauca → Directorio de empresas → Sector agrícola
3. Cámara de Comercio de Cali → Buscador de empresas

**Cooperativas conocidas a investigar primero**:

| # | Nombre | Cultivo | Status |
|---|--------|---------|--------|
| 1 | ASOPROCAÑA (Asoc. de Productores de Caña Panelera) | Caña panelera | Pendiente |
| 2 | ASOHORTICULTORES DEL VALLE | Hortalizas, frutas | Pendiente |
| 3 | Cooperativa Cafetera del Valle | Café | Pendiente |
| 4 | ASOCAÑA Valle (caña azúcar — eval si small farmers también) | Caña | Pendiente |
| 5 | Asociación de Cacaocultores Valle del Cauca (verificar nombre exacto) | Cacao | Pendiente |

**Meta por contacto**:
- Nombre del/la gerente o coordinador/a operativa
- Teléfono fijo + celular
- Email institucional
- Cantidad aproximada de productores asociados (idealmente 20-200)

---

## Fuente 2: Grupos Facebook / WhatsApp de productores

**Cómo buscar**:

1. Facebook → buscar grupos: `"Productores Valle del Cauca"`, `"Agricultores Cali"`, `"Cacao Colombia Valle"`, `"Hortalizas Cali"`, `"Panela Valle"`
2. Identificar 5 grupos activos (publicaciones en últimos 30 días)
3. Identificar líder de grupo (admin) o miembro activo (publica frecuente)

**Meta por contacto**:
- Nombre completo (de perfil público)
- Cómo contactarlo: mensaje directo en Facebook, número en perfil, WhatsApp
- Tipo de cultivo
- Notas sobre si tiene finca propia o representa a otros

**Tarea esposa (perfil más natural en redes)**:
- Unirse a 5 grupos
- Observar dinámica 2-3 días antes de mensajear
- Mensaje inicial NO comercial: pregunta genuina o comentario en post

---

## Fuente 3: Confecámaras Valle del Cauca (productores formalizados)

**Cómo buscar**:

1. https://www.confecamaras.org.co → Cámara de Cali → Directorio empresarial
2. Filtrar por CIIU agrícola: `0111` (cereales), `0113` (hortalizas), `0127` (cacao), `0125` (frutas), `0128` (caña)
3. Filtrar por tamaño: micro/pequeña empresa
4. Ubicación: Valle del Cauca

**Meta por contacto**:
- Razón social
- Representante legal (nombre real)
- Dirección de la finca/empresa
- Teléfono y email registrados
- Cultivo principal según código CIIU

**Ventaja de este canal**: contactos formalizados; más probable que entiendan trazabilidad y certificaciones.

---

## Fuente 4: Gremios / Instituciones (referidos)

**Cómo funciona**: no contactas directamente al productor; contactas al gremio para que te refiera 2-3 productores que ellos consideren buenos candidatos para piloto.

**Lista a contactar**:

| # | Institución | Foco | Pregunta a hacer |
|---|-------------|------|------------------|
| 1 | Secretaría de Agricultura Valle del Cauca | Política agropecuaria regional | "¿Conoce productores pequeños interesados en herramientas de trazabilidad?" |
| 2 | FEDECACAO (capítulo Valle) | Cacao | "¿Me podría referir 2-3 productores asociados para mostrarles una herramienta?" |
| 3 | FEDEPANELA Valle | Panela | Misma pregunta |
| 4 | Comité de Cafeteros del Valle | Café | Misma pregunta |
| 5 | CORPOICA / AGROSAVIA Palmira | Investigación agropecuaria | "¿Tienen productores en proyectos piloto que podrían ser early adopters?" |

**Meta por contacto**: 2-3 referidos por institución (potencialmente 10-15 referidos en total, de los cuales priorizas 5).

---

## Plantilla de registro (1 por contacto)

Crear un archivo CSV o Google Sheet con estos campos:

```
id,nombre,organizacion_o_finca,cultivo,telefono,email,canal,fuente,notas,fecha_contacto_inicial,status
```

**Ejemplo (datos sintéticos)**:

```
01,Juan Productor Ejemplo,Finca La Esperanza,Cacao,+57-300-XXX-YYYY,juan@ejemplo.co,WhatsApp,Cooperativa ASOPROCAÑA,"Tiene 8 hectáreas; refiere también a su vecino",2026-05-12,pendiente
```

### Diccionario de campos

| Campo | Tipo | Valores válidos | Notas |
|-------|------|-----------------|-------|
| `id` | string | `01` a `20` | Cero a la izquierda |
| `nombre` | string | Texto libre | Nombre completo |
| `organizacion_o_finca` | string | Texto libre | Nombre de finca o asociación |
| `cultivo` | enum | `cacao`, `cafe`, `caña`, `hortalizas`, `frutas`, `otro` | Cultivo principal |
| `telefono` | string | `+57-XXX-XXX-XXXX` | Formato internacional |
| `email` | string | RFC 5322 | Vacío si no hay |
| `canal` | enum | `WhatsApp`, `Llamada`, `Email`, `Presencial`, `Facebook` | Canal preferido del prospecto |
| `fuente` | string | Cooperativa X, Confecámaras, FB grupo Y, gremio Z | Cómo lo encontraste |
| `notas` | string | Texto libre | Por qué crees que aplica; referidos adicionales |
| `fecha_contacto_inicial` | date | `YYYY-MM-DD` | ISO 8601 |
| `status` | enum | `pendiente`, `contactado`, `agendado`, `completado`, `descartado` | Pipeline simple |

### Recomendación de almacenamiento

- **Google Sheet** compartido entre Diego y esposa (acceso simultáneo, historial)
- **NO** usar Excel local sin sincronización (te toparás con conflictos)
- Backup mensual exportando a CSV → guardar en `agritrace-docs/01-preparacion-mvp/10-comercial-gtm/data/contactos-YYYY-MM.csv` (gitignored si tiene PII)

---

## Mini checklist Semana 1

- [ ] Crear Google Sheet con plantilla de campos arriba
- [ ] Lunes-Martes: Diego identifica Fuentes 1, 3 y 4 (15 contactos)
- [ ] Lunes-Martes: Esposa identifica Fuente 2 (5 contactos)
- [ ] Miércoles: revisión conjunta del sheet, eliminar duplicados, priorizar
- [ ] Jueves-Viernes: enviar primer contacto (WhatsApp/email/llamada) con [`03-pitch-30s-y-2min.md`](03-pitch-30s-y-2min.md)
- [ ] Cierre Semana 1: 20 contactos identificados, 20 mensajes/llamadas enviados

---

## Mini checklist Semana 2

- [ ] Seguimiento a no-respondieron (3 días después del primer contacto)
- [ ] Agendar las 5-10 calls que aceptaron
- [ ] Confirmar 24h antes de cada call
- [ ] Preparar link de demo agritrace-demo (Vercel) para compartir en cada call

---

## Anti-patrones (qué NO hacer)

- ❌ Contactar a productores genéricos sin investigar su cultivo
- ❌ Mandar el mismo mensaje copy-paste sin personalizar
- ❌ Llamar a más de 5 al mismo tiempo sin tomar notas
- ❌ Insistir más de 2 veces a quien no responde (descártalo)
- ❌ Prometer cosas que no están en MVP (certificaciones, exportación, marketplace)

---

## Referencias

- Pitch para usar en cada contacto: [`03-pitch-30s-y-2min.md`](03-pitch-30s-y-2min.md)
- Canales detallados: [`02-canales-acceso.md`](02-canales-acceso.md)
- Cronograma: [`09-cronograma-validacion-4-semanas.md`](09-cronograma-validacion-4-semanas.md)
- Sub-segmentos: [`01-icp-y-segmentacion.md`](01-icp-y-segmentacion.md)
