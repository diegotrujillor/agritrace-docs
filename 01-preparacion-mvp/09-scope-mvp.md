# Declaración de Alcance MVP

**Fecha**: Mayo 2026  
**Versión**: 1.0  
**Estado**: Aprobado para desarrollo  
**Responsable**: Equipo Producto + Equipo Técnico

---

## 1. Visión MVP

**Crear una app móvil simple que permita a agricultores registrar digitalmente sus actividades de cultivo offline, recibir alertas automáticas, y eventualmente conectar con compradores de EU.**

El MVP valida el problema (agricultores necesitan mejor registro de actividades) y comienza a construir la base para la propuesta de valor diferenciadora (conexión con compradores internacionales). La validación de mercado ocurre con usuarios reales durante Phase 1.

---

## 2. Target User (Fase 1)

| Atributo | Descripción |
|----------|------------|
| **Quién** | Pequeños y medianos agricultores (5-50 hectáreas) en Colombia |
| **Dolor principal** | Dificultad registrar fechas de siembra, fertilización, aplicación de químicos (actualmente: cuadernos, Excel, almanaque + lápiz) |
| **Geografía** | Piloto: 1 región (recomendado Eje Cafetero para acceso a cooperativas) |
| **Dispositivo** | Smartphone (eventual); actualmente 50% tienen básicos o lapicero+cuaderno |
| **Conectividad** | Intermitente (3G/4G rural); 1 de 4 nunca tiene conexión |
| **Disposición a pagar** | Baja (promedio 2.25/5 en escala Likert). Business model alternativo: B2B via cooperativas o buyer-subsidized |

---

## 3. Scope: Qué SÍ incluye (MVP)

### Features Críticas (Must-Have)

- **Registro de actividades offline**: Cada agricultor puede registrar siembra, fertilización, cosecha, aplicación de químicos con fechas, notas y fotos. Funciona sin conexión.
- **Login y onboarding**: Registrarse como productor, crear cuenta, acceder a app.
- **Gestión de fincas y lotes**: Crear múltiples fincas, múltiples lotes por finca, con coordenadas GPS y cultivo principal.
- **Timeline de actividades**: Ver historial cronológico de lo que pasó en cada lote.
- **Sincronización automática**: Cuando hay conexión, los datos se sincronizan al servidor (WatermelonDB + API Node.js).
- **Offline-first por 14+ días**: Agricultor puede trabajar sin conexión; app no pierde datos.

### Features Secundarios (Should-Have si tiempo)

- **Alertas de clima**: Notificaciones simples de lluvia/temperatura si hay acceso a API de clima.
- **Alertas de actividades**: Recordatorios para tareas programadas.
- **SMS/USSD fallback**: Alertas por SMS para agricultores con teléfono básico.
- **Indicador de estado de sincronización**: Mostrar "Offline" vs. "Sincronizando" para claridad.

### Pantallas Incluidas (10 de 13 diseñadas)

1. Bienvenida
2. Registro
3. Login
4. Dashboard vacío
5. Dashboard con fincas
6. Registrar finca
7. Vista finca
8. Registrar lote
9. Vista lote + timeline actividades ⭐ (pantalla más importante)
10. Registrar actividad

---

## 4. Scope: Qué NO incluye (Phase 2+)

### Features Deferidas (Razón)

| Feature | Razón diferencia |
|---------|-----------------|
| **Generar QR y compartir trazabilidad** | Marketplace feature; cero demanda en stakeholders (2/4 dicen "compradores no piden traceability"). Validar en Phase 1.5 con 5+ compradores. |
| **Dashboard para cooperativas** | B2B no es imperative; Phase 2 si partners (Federacafé, etc.) lo requieren. |
| **Dashboard para exportadores/compradores** | Zero buyer respondents. Validar demanda antes de invertir. |
| **Certificaciones digitales** | 3/4 agricultores valoran certs pero ninguno las tiene hoy. Requiere partner con cuerpo certificador. Phase 2. |
| **Chat/messaging con compradores** | Sin demanda. Phase 2 si marketplace se valida. |
| **Web app** | Mobile-first. Laptops pueden acceder vía responsive mobile web, pero no es prioridad. |
| **Field agent / proxy data entry** | Agrega complejidad de onboarding. Defer a Phase 2 si cooperativas requieren. |
| **Analytics dashboard avanzado** | Keep reports simple (PDF export de activity log). Dashboards analytics son Phase 2+. |

---

## 5. Supuestos Clave (Riesgos Conocidos)

| Suposición | Confianza | Plan si falla |
|-----------|-----------|-----------------|
| **Agricultores adoptarán smartphones**: Hoy 50% usan básicos/nada. Asumimos gradual adoption. | **Baja (⚠️)** | Agregar SMS/USSD fallback; evaluar web-responsive para laptops en Phase 2. |
| **Offline-first es correcta arquitectura**: 4/4 dijeron "sí" a offline pero solo 2/4 tienen siempre conexión. | **Alta (✅)** | Validado. Todos los screens deben funcionar offline 14+ días. |
| **Activity log + alerts es el wedge**: Stakeholders no pidieron marketplace/buyer dashboard. | **Media (⚠️)** | Validar con 10+ más agricultores en Weeks 1-2. Ajustar prioridades si marketplace tiene demanda oculta. |
| **Farmers won't pay directo por SaaS**: Promedio willingness 2.25/5 (max 3/5). | **Alta (✅)** | Business model pivote necesario (B2B via coop, buyer-subsidized, freemium, o NGO subsidy). MVP no incluye paywall. |
| **1 región es suficiente para MVP**: No intentar ser nacional día 1. | **Alta (✅)** | Go-live en Eje Cafetero (Huila, Tolima, Caldas) con 1 cooperativa partner. |

---

## 6. Definición de "Done" (MVP Completado)

### Criterio Técnico

- [ ] 10 pantallas implementadas en Flutter con offline-first (WatermelonDB)
- [ ] Sincronización bidireccional funcionando (upload + download changes)
- [ ] 80%+ test coverage
- [ ] API endpoints documentados y testeados
- [ ] PostgreSQL schema deployable

### Criterio Producto

- [ ] Field test con 5 agricultores por 2 semanas (actividades reales registradas offline + sync)
- [ ] UX testing: pantalla de activity log es tan simple como cuaderno (SUS score > 60)
- [ ] Alerts funcionales (SMS o in-app)
- [ ] Offline works for 14+ days sin conexión

### Criterio Negocio

- [ ] 1 cooperativa o partner identificado para pilot (no requiere pago MVP, pero señal de adoption)
- [ ] Market validation: 10+ agricultores dicen "usaría esto" en field interviews

---

## 7. Timeline

**6 semanas (Fase 1 aún aplicable):**

| Semana | Hito |
|--------|------|
| 1-2 | Sprints 1-2: Auth, farm/plot management, basic activity log. Flutter screens 1-8. |
| 3 | Sprint 3: Activity timeline (pantalla 9) + register activity (pantalla 10). WatermelonDB integration. |
| 4 | Sprint 4: Sync engine, offline indicator, alerts, SMS fallback (if time). |
| 5 | Sprint 5: Field test con 5 agricultores. Bug fixes. |
| 6 | Sprint 6: Final refinement, beta release. |

---

## 8. No Incluye (Explícitamente Out of Scope)

- Web admin dashboard
- Multi-language support (Spanish only for MVP)
- Blockchain/immutable ledger
- Real-time collaboration
- Advanced crop modeling
- Payment processing
- Blockchain/NFT certifications

---

## 9. Success Metrics (MVP)

| Métrica | Objetivo | Medida |
|---------|----------|--------|
| **Adoption** | 5+ agricultores en field test activamente usando | # unique active users |
| **Activity logging** | 10+ actividades/día registradas en promedio | # activity records |
| **Offline resilience** | App function sin conexión por 14 días | Field test sin internet |
| **Sync correctness** | 100% de datos synced sin pérdida | Verificar contra DB después de sync |
| **UX simplicity** | Activity log screen SUS score > 60 | User testing score |

---

## 10. Aprobaciones

- ✅ **Equipo Producto**: Scope aprobado, features priorizadas, marketplace diferido
- ✅ **Equipo Técnico**: Architecture viable (Flutter + WatermelonDB + Node.js API)
- 🔲 **Stakeholder/Cooperativa**: Pending — identificar partner para pilot

---

## Referencias

- Estudio stakeholders: `/01-preparacion-mvp/01-encuesta-partes-interesadas/02-encuesta-partes-interesadas-respuestas.md`
- Análisis de viabilidad: Generated by architecture review (Mayo 2026)
- Feature prioritization: `/01-preparacion-mvp/04-diseno-ui-ux/01-priorizacion-features-mvp.md`
- Offline storage technical spec: `/01-preparacion-mvp/04-diseno-ui-ux/offline-storage-decision.md`
- Screen specifications: `/01-preparacion-mvp/04-diseno-ui-ux/02-especificaciones-pantallas/01-especificaciones-pantallas.md`
