# 10 - Métricas y KPIs de Validación

**Objetivo**: definir las métricas que nos dirán si la validación del MVP en Phase 1 fue exitosa o no.

**Principio**: pocas métricas, claras, accionables. Si una métrica no cambia una decisión, no la midas.

---

## Métricas por Semana

### Semana 1 — Identificación

| Métrica | Meta | Fuente |
|---------|------|--------|
| Prospectos identificados con nombre + tel/email | 20 | Google Sheet |
| Mensajes de primer contacto enviados | 20 | Google Sheet |
| Pitches memorizados (Diego + Esposa) | 2/2 | Auto-reporte |

### Semana 2 — Contacto y agenda

| Métrica | Meta | Fuente |
|---------|------|--------|
| Tasa de respuesta a primer contacto | ≥ 30% (6+ de 20) | Google Sheet `status` |
| Calls agendadas | ≥ 5 | Calendario |
| Demo de [`agritrace-demo`](https://github.com/diegotrujillor/agritrace-demo) operativa | ✅ | Test manual |

### Semana 3 — Calls y feedback

| Métrica | Meta | Fuente |
|---------|------|--------|
| Calls completadas | ≥ 5 | Plantilla post-call |
| Pilotos firmados (contrato feedback) | ≥ 2 | Contratos firmados |
| Feedback points documentados | ≥ 10 | Plantillas post-call agregadas |

### Semana 4 — Onboarding

| Métrica | Meta | Fuente |
|---------|------|--------|
| Pilotos con cuenta creada | = pilotos firmados | Backend |
| Pilotos con ≥ 1 actividad registrada | = pilotos firmados | Backend (tabla `activities`) |
| Calls semanales agendadas para Semanas 5-8 | = pilotos firmados × 4 | Calendario |

---

## Métricas durante el Mes 1 del piloto (Semanas 5-8)

### Métricas de uso

| Métrica | Meta | Frecuencia |
|---------|------|------------|
| Actividades registradas / piloto / semana | ≥ 2 | Semanal |
| Días con actividad / piloto / semana | ≥ 2 | Semanal |
| Sincronizaciones offline → online | ≥ 1 / semana | Semanal |
| Pilotos activos (≥1 actividad en últimos 7 días) | ≥ 80% del total firmado | Semanal |

### Métricas de feedback

| Métrica | Meta | Frecuencia |
|---------|------|------------|
| Calls semanales realizadas | 1 / piloto / semana | Semanal |
| Bugs reportados | Sin meta — registrar todos | Continuo |
| Solicitudes de feature | Sin meta — registrar y priorizar | Continuo |

### Métricas de pricing (escalera de [`06-modelo-pricing-validacion.md`](06-modelo-pricing-validacion.md))

| Métrica | Cuándo se captura |
|---------|-------------------|
| Precio mencionado por piloto en pregunta exploratoria | Semana 2 del piloto |
| Reacción a $10K vs $29.990 | Semana 3 del piloto |
| Decisión final pago / no pago | Semana 4 del piloto (cierre Mes 1) |

---

## Métricas de Resultado Final (Cierre Mes 1)

### Métricas duras (cuantitativas)

| Métrica | Meta verde | Meta amarillo | Meta rojo |
|---------|-------------|---------------|-----------|
| Pilotos que dijeron "pago $29.990" | ≥ 2 | 1 | 0 |
| Pilotos que dijeron "pago a precio menor" | ≥ 1 adicional | 0-1 | 0 |
| Pilotos que dijeron "lo pagaría la coop" | ≥ 1 | 0-1 | 0 |
| Tasa de actividad sostenida (%) | ≥ 80% | 50-79% | < 50% |
| Conversión piloto → pago | ≥ 40% | 20-39% | < 20% |

### Métricas blandas (cualitativas)

Capturar narrativamente:

| Pregunta | Cómo se responde |
|----------|------------------|
| ¿Cuál fue el dolor más mencionado? | Frases textuales agregadas de plantillas post-call |
| ¿Qué feature pidieron más? | Lista priorizada de feature requests |
| ¿Qué objeción apareció más en calls? | Lista de objeciones y respuestas que funcionaron |
| ¿Qué les confundió de la UX? | Lista de fricciones reportadas |
| ¿En qué canal funcionó mejor el contacto inicial? | Tasa de respuesta por canal |

---

## Sistema de captura

### Google Sheet único (no se complica más)

Una sola hoja con pestañas:

| Pestaña | Contenido |
|---------|-----------|
| `Prospectos` | 20 contactos iniciales (Semana 1) — campos de [`04-lista-contactos-20.md`](04-lista-contactos-20.md) |
| `Calls` | 1 fila por call completada — fecha, prospecto, duración, decisión, willingness |
| `Pilotos` | 1 fila por piloto firmado — fecha firma, fecha cuenta, primera actividad, semanas activo |
| `Pricing` | 1 fila por piloto × semana — respuestas a escalera de precio Semanas 2-4 |
| `Feedback` | 1 fila por feedback point — tipo (bug/feature/objeción/UX), cita textual, prioridad |
| `Resumen` | Métricas agregadas — refresca con fórmulas que apuntan a otras pestañas |

### Backups

- Exportar a CSV mensualmente
- Guardar en `agritrace-docs/01-preparacion-mvp/10-comercial-gtm/data/metricas-YYYY-MM.csv`
- Si hay PII (nombres, teléfonos), gitignore y solo backup local cifrado

### Dashboard simple (opcional)

Para Phase 2: si volumen crece, mover a Notion / Airtable / Metabase. Phase 1 NO lo necesita; un Sheet bien organizado es suficiente.

---

## Decisión binaria al cierre del Mes 1

Con base en [`06-modelo-pricing-validacion.md`](06-modelo-pricing-validacion.md) §"Decisión a tomar al cierre Semana 4":

```
SI (pilotos_pagan_29990 >= 2) ENTONCES
    Veredicto: "Validación FUERTE"
    Acción: continuar plan original, escalar a Phase 2 con cooperativas
ELSE SI (pilotos_pagan_29990 == 1) ENTONCES
    Veredicto: "Validación TIBIA"
    Acción: validar 5 pilotos adicionales antes de pivotar
ELSE SI (pilotos_pagan_menor_precio >= 3) ENTONCES
    Veredicto: "Pricing alto"
    Acción: bajar a $14.990 + 1 mes adicional de validación
ELSE SI (pilotos_dicen_coop_paga >= 3) ENTONCES
    Veredicto: "Modelo B2B"
    Acción: pivote a B2B-via-coop
ELSE
    Veredicto: "Pivote estructural"
    Acción: revisar problema-solución, segmento o producto
FIN
```

---

## Reporte estilo "1-pager"

Al cierre de Semana 4 + Mes 1 piloto, generar 1 página con:

```
─────────────────────────────────────────────────────
AgriTrace - Reporte Validación Phase 1
Fecha: YYYY-MM-DD
─────────────────────────────────────────────────────

NÚMEROS DUROS
- Prospectos contactados: XX/20
- Tasa de respuesta: XX%
- Calls completadas: XX
- Pilotos firmados: XX
- Pilotos activos al cierre: XX
- Pilotos que pagarían $29.990: XX
- Pilotos que pagarían menor precio: XX
- Pilotos que dicen "que pague la coop": XX

DOLOR PRINCIPAL VALIDADO
"[cita textual del dolor más recurrente]"

FEATURE MÁS PEDIDO (Phase 2)
[descripción + frecuencia]

VEREDICTO
[Validación fuerte / tibia / pricing alto / B2B / pivote]

ACCIÓN PARA PRÓXIMOS 30 DÍAS
1. [acción concreta]
2. [acción concreta]
3. [acción concreta]

─────────────────────────────────────────────────────
```

Compartir este 1-pager con esposa + (opcional) cualquier asesor / mentor.

---

## Anti-patrones de medición

- ❌ **Vanity metrics**: "10 cooperativas vieron mi LinkedIn post" (no es señal de mercado)
- ❌ **Promedios sin distribución**: "Promedio 3.5/5 en encuesta" oculta patrones
- ❌ **Datos sin contexto**: "5 pilotos" — ¿de qué cultivo, qué región, qué tamaño?
- ❌ **Métricas que no cambian decisiones**: si capturas algo y nunca lo usas, deja de capturarlo
- ❌ **Comparar con startups americanas**: "Stripe creció 1000% mes-mes" — no aplica a agritech rural

---

## Referencias

- Plantilla post-call (donde nacen muchas métricas): [`05-guion-call-validacion.md`](05-guion-call-validacion.md)
- Modelo de pricing (decisión final usa estas métricas): [`06-modelo-pricing-validacion.md`](06-modelo-pricing-validacion.md)
- Cronograma (cuándo medir cada cosa): [`09-cronograma-validacion-4-semanas.md`](09-cronograma-validacion-4-semanas.md)
- Plantilla del Sheet: [`04-lista-contactos-20.md`](04-lista-contactos-20.md)
