# Priorización de Features MVP

**Fecha de decisión**: Mayo 2026  
**Estado**: MVP Ejecutable (Enfoque: Farmer-First, Mobile-Only)  
**Responsable**: Equipo Producto

## Estrategia MVP

**Objetivo**: App móvil simple que permita a agricultores registrar actividades offline y recibir alertas. La conexión con compradores de EU es la propuesta de valor innovadora, pero se valida en el mercado durante MVP (no es feature obligatoria día 1).

**Alcance**: 10 pantallas móviles de flujo productor. Marketplace y flujos cooperativa/comprador diferidos a Phase 2.

**Suposición clave**: Los agricultores adoptarán smartphones gradualmente. El app es solo móvil (no web).

---

## Pantallas: MVP vs. Phase 2

### ✅ MVP (Incluidas — 10 pantallas)

**Autenticación**
| Pantalla | Descripción | P0 Rationale |
|----------|-------------|--------------|
| 1 | Bienvenida | Entrada a app |
| 2 | Registro | Crear cuenta productor |
| 3 | Login | Acceso recurrente |

**Dashboard Productor**
| Pantalla | Descripción | P0 Rationale |
|----------|-------------|--------------|
| 4 | Dashboard vacío | First-time experience |
| 5 | Dashboard con fincas | Listado de propiedades |

**Fincas y Lotes**
| Pantalla | Descripción | P0 Rationale |
|----------|-------------|--------------|
| 6 | Registrar finca | Pain point R1, R4: tracking farm info |
| 7 | Vista finca | Navegar lotes |
| 8 | Registrar lote | Core record-keeping |

**Actividades**
| Pantalla | Descripción | P0 Rationale |
|----------|-------------|--------------|
| 9 | Vista lote + timeline actividades | **Pantalla más importante**: registro de actividades con fechas, químicos, fertilización (dolor punto R1, R2, R4 de survey Oct 2025) |
| 10 | Registrar actividad | Log entries with photos, notes, timestamps |

---

### ⏸️ Phase 2 (Diferidas)

**Marketplace/Trazabilidad**
| Pantalla | Descripción | Razón diferencia |
|----------|-------------|-----------------|
| 11 | Generar QR | Marketplace feature; 0 demand signal en stakeholders |
| 12 | QR Fullscreen | Marketplace feature |
| 13 | Trazabilidad pública (web) | Buyer-facing; requiere validación con 5+ compradores |

**Flujos no-MVP**
| Flujo | Razón diferencia |
|------|-----------------|
| Flow B (Cooperativa) | B2B model no imperative; Phase 2 si partners requieren |
| Flow C (Exportador/Comprador) | Zero buyer respondents; validar Phase 1.5 |

---

## MoSCoW Mapping

### Must (MVP puede completarse sin estos — MVP puede fallar con estos)

| Feature | Must | Phase 2 |
|---------|------|---------|
| Offline activity logging (R1-R4: 4/4 respondents) | ✅ | |
| Dates/fertilization tracking (R1, R2, R4: 3/4) | ✅ | |
| Photo capture for records (R3, R4: 2/4) | ✅ | |
| Alerts/reminders (R1, R4: 3/4) | ✅ | |
| Farm + plot management | ✅ | |
| Login/registration | ✅ | |

### Should (Nice-to-have, depende de timeline)

| Feature | Timeline |
|---------|----------|
| SMS/USSD fallback para alertas (respondents R1, R3 sin smartphone) | Week 4 (MVP o post-launch) |
| UI estado de conectividad (indicador offline/sincronizando) | Week 3 |
| Alertas de clima (respondents R1, R4: 2/4) | Week 4 |
| Calendario de cultivos/recordatorios cosecha | Week 4 |

### Could (Explorar después)

| Feature | Phase |
|---------|-------|
| QR generation | Phase 2 |
| In-app buyer messaging | Phase 2 |
| Certifications workflow | Phase 2 |
| Analytics dashboards | Phase 2 |

### Won't (Out of scope)

| Feature | Razón |
|---------|-------|
| App web | Decisión mobile-first (solo Flutter) |
| Modo entrada por agente de campo | Agrega complejidad de onboarding |
| Jerarquía multi-usuario/cooperativa | Defer a B2B en Phase 2 |
| Blockchain/ledger | Cero demanda en stakeholders |

---

## Flujo de Desarrollo por Semana

### Semana 1-2 — Autenticación y Onboarding (Pantallas 1-3)

| Pantalla | Flujo | Detalle |
|----------|-------|---------|
| 1. Bienvenida | App abre → Hero con CTA | Logo + 3 slides con beneficios + botones "Ingresar" / "Crear cuenta" |
| 2. Registro | Crear cuenta productor | Nombre, email, teléfono, contraseña. Verificación SMS. Rol = Productor. |
| 3. Login | Acceso recurrente | Email + contraseña. Link "recuperar contraseña". |

**Hito:** Usuario autenticado puede acceder al dashboard vacío.

---

### Semana 2-3 — Gestión de Fincas y Lotes (Pantallas 4-8)

| Pantalla | Flujo | Detalle |
|----------|-------|---------|
| 4. Dashboard vacío | Primera visita post-login | Ilustración + CTA "Registra tu primera finca". Funciona offline. |
| 5. Dashboard con fincas | Listado de propiedades | Tarjetas: nombre, municipio, cultivo principal. |
| 6. Registrar finca | Crear finca nueva | Nombre, municipio/vereda, GPS (entrada manual como alternativa), cultivo, área. |
| 7. Vista finca | Ver finca + lotes | Nombre, coordenadas, botón "Registrar lote", lista de lotes. |
| 8. Registrar lote | Crear lote en finca | Nombre, cultivo, área, foto opcional. |

**Hito:** Agricultor crea 1 finca + 1-3 lotes y puede navegar la estructura.

---

### Semana 3-4 — Registro de Actividades + Timeline (Pantallas 9-10) ⭐ CORE MVP

| Pantalla | Flujo | Detalle |
|----------|-------|---------|
| 9. Vista lote + timeline | Ver historial de actividades | Timeline vertical cronológico, botones "Registrar actividad" y "Generar QR". **Pantalla más usada del MVP.** |
| 10. Registrar actividad | Log con foto, notas y fecha | Selector de tipo → fecha (pre-llenada) → insumo/dosis → notas → foto → guardar. **Funciona 100% sin conexión.** |

**Hito:** Agricultor registra siembra, fertilización, cosecha con fotos. Timeline actualiza. Datos persisten offline.

---

### Semana 4 — Sincronización + Indicadores de Conectividad

| Feature | Pantallas afectadas | Detalle |
|---------|---------------------|---------|
| Motor de sincronización (push/pull) | Todas | WatermelonDB sincroniza automáticamente al recuperar conexión. |
| Indicador offline/sincronizando | 9, 10 | Header muestra estado claro: "Sin conexión" o "Sincronizando...". |
| SMS/USSD fallback para alertas | Sistema | Alertas por SMS para agricultores sin smartphone (R1, R3 del survey). |

**Hito:** Sincronización bidireccional funcionando. El agricultor trabaja 14+ días sin conexión sin perder datos.

---

### Semana 4-5 — Refinamiento UI/UX + Pruebas

| Tarea | Pantallas | Criterio |
|-------|-----------|----------|
| Refinamiento UX activity log | 9, 10 | Simple como cuaderno (SUS score > 60) |
| Prueba de flujo offline completo | 6-10 | 14+ días sin conexión, 0 pérdida de datos |
| Compresión de fotos | 8, 10 | Auto-resize para conexión lenta |
| Validación de formularios | Todos | Mensajes amigables, tooltips contextuales |

**Hito:** Todas las pantallas funcionales y pulidas para field test.

---

### Semana 5-6 — Field Test + Preparación de Lanzamiento

| Actividad | Enfoque | Resultado esperado |
|-----------|---------|-------------------|
| Field test con 5 agricultores | Pantallas 6-10 en uso real | 10+ actividades registradas/agricultor en 2 semanas |
| Corrección de bugs | Todas las pantallas | Cero crashes, tiempo de carga < 5 seg offline |
| Checklist de lanzamiento | Todo el sistema | API keys, migraciones DB, documentación de despliegue lista |

**Hito:** Beta release. MVP listo para piloto con 1 cooperativa.

---

## KPIs MVP (Semana 5 — Field Test)

| Métrica | Objetivo | Criticidad |
|---------|----------|------------|
| Agricultores activos en field test | 5 agricultores | MUST |
| Actividades registradas | 10+ por agricultor en 2 semanas | MUST |
| Resiliencia offline | App funciona 14+ días sin conexión, 0 pérdida de datos | MUST |
| UX registro de actividades (SUS score) | > 60 | MUST |
| Sincronización correcta | 100% de registros sincronizados, 0 pérdidas | MUST |
| Tiempo para registrar actividad | < 3 minutos (Pantalla 10) | SHOULD |

---

## Qué NO incluye el MVP (Diferido a Phase 2)

| Feature / Pantalla | Razón | Phase |
|--------------------|-------|-------|
| Pantalla 11: Generar QR | Marketplace feature; cero demanda en stakeholders (2/4 dicen que compradores no piden trazabilidad) | 2 |
| Pantalla 12: QR Fullscreen | Buyer-facing feature sin demanda validada | 2 |
| Pantalla 13: Landing pública de trazabilidad | Requiere validación con 5+ compradores/exportadores | 2 |
| Dashboard Cooperativa | Modelo B2B no es imperativo para MVP; agregar si partners lo requieren | 2 |
| Validación de certificaciones | Requiere partner con cuerpo certificador (Rainforest Alliance, etc.) | 2 |
| Panel Administrador | Solo autenticación básica en MVP; admin panel en versión posterior | 2+ |
| Mensajería comprador-productor | Sin señal de demanda en ningún stakeholder | 2 |
| Reportes y analíticas avanzadas | Mantener reportes simples (export PDF del activity log) | 2+ |
| App web / web responsive | Decisión mobile-first — solo Flutter | Nunca (MVP) |
| Modo entrada por agente de campo | Agrega complejidad de onboarding innecesaria en MVP | 2 |
| Flujo cooperativa (invitación masiva, gestión de productores) | B2B: diferir hasta tener 1 cooperativa partner confirmada | 2 |
| Flujo exportador/comprador (búsqueda, contacto) | Marketplace: diferir hasta validar demanda del lado comprador | 2 |

---

## Notas para Desarrolladores

1. **Activity log (Pantalla 9) es la pantalla más importante**: Invierta tiempo en UX. Debe ser tan simple como escribir en un cuaderno (notebook mental model).

2. **Offline es no-negotiable**: Todos los screens deben funcionar sin conexión por 14+ días.

3. **Alertas basadas en SMS/USSD**: 2 de 4 stakeholders no tienen smartphone. Fallback crítico.

4. **Marketplace features (QR, buyer dashboard) son Phase 2**: La validación de mercado ocurre durante MVP con farmers reales usando el app. Si los compradores de EU realmente demandan traceability, agregue Phase 2.

---

## Referencias

- Especificaciones técnicas: `/01-preparacion-mvp/04-diseno-ui-ux/02-especificaciones-pantallas/01-especificaciones-pantallas.md`
- Análisis offline storage: `/01-preparacion-mvp/04-diseno-ui-ux/offline-storage-decision.md`
- Respuestas stakeholders: `/01-preparacion-mvp/01-encuesta-partes-interesadas/02-encuesta-partes-interesadas-respuestas.md`
