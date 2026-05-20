# Sprint 5 — Runbook del piloto en campo

**Fecha de inicio**: 2026-05-19  
**Duración nominal**: **30 días (1 mes)** — coherente con el contrato
comercial [`10-comercial-gtm/07-contrato-feedback-piloto.md`](../10-comercial-gtm/07-contrato-feedback-piloto.md)
(piloto Mes 1) y `09-scope-mvp.md §6`.
> El piso técnico de offline (14+ días) sigue vigente como criterio
> arquitectural; el piloto de 30 días provee margen extra para
> evidenciarlo.  
**Objetivo del sprint** (per
[`09-scope-mvp.md §7`](../09-scope-mvp.md#7-timeline)): *"Field test con
5 agricultores. Bug fixes."*

> Este runbook es la **vista técnica/operativa**.  
> Lado comercial: [`07-contrato-feedback-piloto.md`](../10-comercial-gtm/07-contrato-feedback-piloto.md).  
> Métricas comerciales acumuladas: [`pilotos.csv`](../10-comercial-gtm/data/metricas/pilotos.csv).  
> Hoja para enviar al agricultor: [`02-tester-onboarding-es-CO.md`](02-tester-onboarding-es-CO.md).

---

## 1. Roster de testers (objetivo ≥5)

| # | Nombre | Cooperativa / Vereda | Dispositivo | Email | Canal preferido | Onboarded |
|---|--------|----------------------|-------------|-------|-----------------|-----------|
| 1 |  |  |  |  | WhatsApp |  |
| 2 |  |  |  |  | WhatsApp |  |
| 3 |  |  |  |  | WhatsApp |  |
| 4 |  |  |  |  | WhatsApp |  |
| 5 |  |  |  |  | WhatsApp |  |
| 6 | _opcional, buffer_ |  |  |  | WhatsApp |  |
| 7 | _opcional, buffer_ |  |  |  | WhatsApp |  |

> Cubrir 7 si es posible: 2 de margen porque siempre cae alguno por
> dispositivo incompatible o cambio de minuto.  
> Datos comerciales (firma de contrato, semanas activo) se llevan
> aparte en `pilotos.csv`.

---

## 2. Distribución del APK

Mientras la app no esté en Play Internal testing
(prerequisitos en
[`agritrace-mobile/docs/PLAY_CONSOLE_SETUP.md`](https://github.com/diegotrujillor/agritrace-mobile/blob/main/docs/PLAY_CONSOLE_SETUP.md)):

- **Canal recomendado para testers:** `https://agritrace.co/#instalar`
  (página pública con botón de descarga + 6 pasos ilustrados + ayuda).
  Compartir ese link por WhatsApp; abre directamente la pestaña de
  instalación.
- Fallback / fuente: `https://github.com/diegotrujillor/agritrace-mobile/releases/latest/download/AgriTrace.apk`
  (lo que la página descarga; útil si el tester ya está técnico).
- Guion 1-a-1 para el onboarding:
  [`02-tester-onboarding-es-CO.md`](02-tester-onboarding-es-CO.md).

Cuando Play Internal testing esté listo, **migrar el canal de
distribución al opt-in link de Play** — elimina sideload + advertencias
Play Protect.

---

## 3. Canal de comunicación

| Canal | Para qué | Quién |
|---|---|---|
| **Grupo WhatsApp `AgriTrace Piloto`** | Pulso diario, reportes en lenguaje natural, dudas, fotos | Diego + testers |
| **GitHub Issues** del repo `agritrace-mobile` | Registro canónico (bugs + feedback estructurado) | Diego transcribe lo del WhatsApp; tester técnico puede abrir directamente |
| **Email `diegotrujillor@gmail.com`** | Cosas privadas (datos personales, derecho ARCO Ley 1581) | Tester → Diego |

Plantillas de issue:
- 🐞 Bug en piloto (Sprint 5) — `.github/ISSUE_TEMPLATE/field-test-bug.yml`
- 💬 Feedback de uso (Sprint 5) — `.github/ISSUE_TEMPLATE/field-test-feedback.yml`

Etiquetas auto-aplicadas: `sprint-5`, `field-test`, + `bug`/`feedback`.
Severidad (manual, añadir al triage): `P0` / `P1` / `P2` / `P3` (ver §5).
Filtro del board: `is:issue label:sprint-5`.

Mensajes listos para copiar-pegar (reclutamiento, pulso diario,
hotfix, cierre): [`03-comms-templates-es-CO.md`](03-comms-templates-es-CO.md).

---

## 4. Ritmo del sprint (30 días)

| Día | Acción de Diego |
|---|---|
| 0 | Onboarding 1-a-1 con cada tester (presencial o video) — instalar, registrar, crear una finca + un lote. ≤45 min cada uno. |
| 1-7 (Sem. 1) | Pulso diario en WhatsApp. Triage de bugs (label + severidad). Hotfixes críticos vía tags `vX.Y.Z` → re-distribuir APK. |
| 7 | Check-in semanal #1: revisar métricas (§6), preguntar 1 cosa estructurada. |
| 8-14 (Sem. 2) | Pulso diario. Atender backlog de feedback. Frenar features nuevos. |
| 14 | Check-in semanal #2 (mitad del piloto): comparar evolución con Sem. 1, confirmar ≥14 días offline observado. |
| 15-21 (Sem. 3) | Pulso diario. Sólo bug fixes; cero scope creep. |
| 21 | Check-in semanal #3: medir SUS-lite informal (1 pregunta), validar Go-tendency. |
| 22-29 (Sem. 4) | Cierre progresivo. Preparar Google Form SUS-10. |
| 30 | Cierre: enviar SUS-10, calcular métricas finales (§6), decidir Go/No-Go para Sprint 6 (release beta). |

---

## 5. Severidad de bugs (triage)

| Severidad | Significado | SLO de fix |
|---|---|---|
| **P0** | Crash al abrir, login imposible, pérdida de datos | mismo día — hotfix tag |
| **P1** | Función crítica rota (no se guarda actividad, sync falla) | 48 h |
| **P2** | UX confuso, error visible sin pérdida de datos | siguiente release semanal |
| **P3** | Cosmético, sugerencia | backlog Sprint 6 |

Cada issue debe tener label de severidad (`P0`/`P1`/`P2`/`P3`) además
de los labels automáticos.

---

## 6. Métricas de éxito (cierre del sprint)

Espejo de [`09-scope-mvp.md §6`](../09-scope-mvp.md):

| Métrica | Meta MVP |
|---|---|
| Agricultores activos al día 30 | ≥5 |
| Actividades registradas / día (mediana de los testers) | ≥10 |
| Capacidad offline observada en campo | ≥14 días continuos sin crash |
| Tasa de éxito de sync (lectura logs `/v1/sync`) | 100 % |
| SUS-10 (System Usability Scale) promedio | >60 |
| P0 abiertos al cierre | 0 |
| P1 abiertos al cierre | ≤2 |

Fuentes:
- Agricultores activos / actividades: consulta SQL a producción
  (ver [`agritrace-backend` migraciones](https://github.com/diegotrujillor/agritrace-backend/tree/main/src/db/migrations)).
- Sync: filtrar `audit_logs.path LIKE '/v1/sync%'` y agrupar por `status_code`.
- SUS-10: Google Form al día 30. Preguntas + scoring + plantilla
  Sheets en [`04-sus-10-cuestionario.md`](04-sus-10-cuestionario.md).

### Plantilla SQL — agricultores activos

```sql
SELECT u.email,
       COUNT(a.id) AS activities_count,
       MIN(a.created_at) AS first_activity,
       MAX(a.created_at) AS last_activity
FROM users u
LEFT JOIN producers p  ON p.user_id    = u.id
LEFT JOIN farms f      ON f.producer_id = p.id
LEFT JOIN plots pl     ON pl.farm_id    = f.id
LEFT JOIN activities a ON a.plot_id     = pl.id
WHERE u.created_at > NOW() - INTERVAL '30 days'
GROUP BY u.email
ORDER BY activities_count DESC;
```

---

## 7. Criterios de salida (Go / No-Go a Sprint 6)

**Go** (proceder a beta release / Play Production prep):
- ≥5 agricultores activos al día 30.
- 0 P0 / ≤2 P1 abiertos.
- Sync success rate 100 %.
- SUS-10 promedio >60.

**No-Go** (extender Sprint 5 o pivotar):
- <3 agricultores activos → problema de adopción, no de producto.
- ≥1 P0 sin resolver al día 30 → estabilidad insuficiente.
- SUS <50 → problema de UX que requiere rediseño antes de beta.

---

## 8. Anti-patrones a evitar durante el sprint

- **Feature creep**: el sprint es bug fixes + observación. No agregar
  pantallas. Toda idea nueva va a backlog Sprint 6.
- **"Anécdota = feature"**: un tester pide algo ≠ los 5 lo piden.
  Capturar pero esperar señal repetida.
- **Sin métrica**: cada bug fix necesita un issue. Sin issue, no
  contamos.
- **Sobre-comunicar técnico**: cero jerga con testers. La app debe
  bastar.

---

## 9. Material para enviar al tester

Una sola hoja, imprimible o screenshot a WhatsApp:
[`02-tester-onboarding-es-CO.md`](02-tester-onboarding-es-CO.md).
