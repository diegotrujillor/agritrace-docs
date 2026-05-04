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
| 9 | Vista lote + timeline actividades | **Pantalla más importante**: activity log with dates, chemicals, fertilization (R1, R2, R4 pain) |
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
| SMS/USSD alert fallback (for R1, R3 sin smartphone) | Week 4 (MVP o post-launch) |
| Settings/connectivity UI (offline/syncing indicator) | Week 3 |
| Climate alerts (R1, R4: 2/4) | Week 4 |
| Crop calendar/harvest reminders | Week 4 |

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
| Web app | Mobile-first decision |
| Field agent proxy mode | Adds onboarding complexity |
| Multi-user/cooperative hierarchy | Defer to B2B in Phase 2 |
| Blockchain/ledger | Zero stakeholder signal |

---

## Hitos de Desarrollo

| Semana | Pantallas | Features |
|--------|-----------|----------|
| **1-2** | 1, 2, 3, 4, 5, 6, 7, 8 | Auth, onboarding, farm/plot management |
| **3** | 9, 10 | Activity log + timeline (core MVP) |
| **4** | 9 refinement | Alerts, offline indicator, SMS fallback |
| **5** | Testing & refinement | Field test con 5 farmers |
| **6** | Bug fixes & launch prep | MVP release candidate |

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
