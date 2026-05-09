# 06 - Modelo de Pricing y Validación de Pago

**Estado**: decisión inicial — sujeta a validación durante Semanas 1-4

**Decisión**: Híbrido de **Mes 1 gratis con commitment contract** → **Mes 2 en adelante $29.990 COP/mes** por productor individual.

---

## El problema que resuelve este modelo

| Pregunta abierta | Respuesta tentativa |
|------------------|----------------------|
| ¿El productor pequeño paga directo? | Probablemente sí a precio bajo, no validado |
| ¿Cuánto está dispuesto a pagar? | Encuesta dijo 2.25/5 (n=4, no concluyente) |
| ¿Quién más puede pagar? | Cooperativa, comprador, NGO (todos opciones B2B/B2B2C) |
| ¿Cómo evitar feedback hueco de "sí gracias gratis"? | Forzar commitment desde día 1 |

---

## Modelo Híbrido: Free Mes 1 + Pago Mes 2

### Mes 1 (Gratuito + Commitment Contract)

- Acceso completo al MVP
- Sin restricciones funcionales
- A cambio:
  1. Uso real ≥ 2 actividades/semana documentadas
  2. 1 call de feedback de 15 min/semana
  3. Decisión franca de "pago/no pago" al cierre del mes

Detalle del compromiso: [`07-contrato-feedback-piloto.md`](07-contrato-feedback-piloto.md)

### Mes 2 en adelante (Pago)

**Precio individual**: **$29.990 COP/mes** por productor.

**Por qué $29.990 COP**:

| Justificación | Detalle |
|---------------|---------|
| Precio anclaje psicológico | Bajo umbral de "treinta mil pesos" — productor pequeño puede asimilarlo |
| Comparación cultural | Cuesta menos que un kg de pollo, similar a un servicio mensual de telefonía básica |
| Margen mínimo viable | A 100 productores activos = $3M COP/mes (cubre costo de infra + soporte) |
| Punto de validación | Si paga $29.990 hay willingness real; si solo paga $10K, hay que pivotar |

**Forma de pago tentativa Mes 2**:
- Nequi / Daviplata (transferencia mensual recurrente)
- PSE (productor formalizado)
- Pago en efectivo via cooperativa (si hay convenio)

**No incluido en Phase 1**: pasarela de pago automática, suscripción tipo Netflix, plan anual con descuento. Esos llegan en Phase 2 cuando haya volumen.

---

## Escalera de validación de precio (durante Mes 1)

Durante las calls semanales del piloto, vas escalando preguntas para mapear sensibilidad de precio:

### Semana 1 del piloto: NO hablar de precio
Foco: que aprenda a usar la app, registre actividades reales.

### Semana 2 del piloto: pregunta exploratoria
```
"Si esta app le ahorrara X minutos cada vez que registra
algo, ¿cuánto pagaría al mes? Sin compromiso, sólo curiosidad."
```

Anota la respuesta. No la negocies. Si dice "$5.000", anótalo.

### Semana 3 del piloto: pregunta direccional
```
"¿Qué le parece más razonable: $10.000 al mes, $29.990,
o más?"
```

Esta es la "pregunta del precio anclado". Posiciona $29.990 como precio central.

### Semana 4 (cierre): pregunta concreta
```
"Mes 1 fue gratis como acordamos. ¿A partir del próximo mes
pagaría $29.990 al mes para seguir usándolo? Sí o no, ambas
respuestas valen."
```

Si dice **sí**: cobrar antes de día 5 del mes 2.
Si dice **no**: pregunta P5b: "¿A qué precio sí pagaría?"
Si dice **no a cualquier precio**: piloto exitoso pero usuario no es cliente. Cierre limpio.

---

## Variantes y ramificaciones

### Si patrón muestra alta sensibilidad de precio (mayoría dice "$10.000 max")

**Acción**: bajar precio a $14.990 COP/mes para Phase 2 + reformular value prop.

**Riesgo**: ARPU baja → necesitas más volumen → presión sobre canales de adquisición.

### Si patrón muestra disposición pero solo via cooperativa

**Acción**: pivotar a modelo B2B-via-coop:
- Cooperativa paga $X COP/mes (flat) y da acceso a sus N productores
- Productor no paga directo
- Diego negocia con coop, no con productor individual

**Riesgo**: ciclo de venta más largo (3-6 meses para cerrar coop), pero ARPU más alta.

### Si patrón muestra disposición buyer-side (B2B2C)

**Acción**: explorar Phase 1.5 con un comprador/exportador:
- Comprador paga por acceso a datos de trazabilidad de su red de productores
- Productor mantiene acceso gratis

**Riesgo**: requiere construir feature de buyer access (Phase 2 ya planeada). Hold off hasta validar.

### Si patrón muestra "nadie paga" (peor escenario)

**Acción**: pivote más profundo:
- Validar si el problema real está bien identificado
- Considerar otro segmento (latifundista, agroindustria)
- O reposicionar AgriTrace como herramienta de gestión interna (no SaaS)

**Riesgo**: pivote estructural — implica revisar PRD completo.

---

## Modelo financiero indicativo (3 escenarios Mes 2)

### Escenario A — Validación fuerte (best case)

| Métrica | Valor |
|---------|-------|
| Pilotos firmados Mes 1 | 5 |
| Conversión a pago Mes 2 | 3 (60%) |
| Ingreso Mes 2 | 3 × $29.990 = $89.970 COP |
| Ingreso Mes 3 (asumiendo retención + nuevos) | $179.940 COP |

### Escenario B — Validación tibia (base case)

| Métrica | Valor |
|---------|-------|
| Pilotos firmados Mes 1 | 5 |
| Conversión a pago Mes 2 | 1 (20%) |
| Ingreso Mes 2 | 1 × $29.990 = $29.990 COP |
| Decisión | Pivote canal o pivote pricing |

### Escenario C — Validación baja (worst case que aún informa)

| Métrica | Valor |
|---------|-------|
| Pilotos firmados Mes 1 | 5 |
| Conversión a pago Mes 2 | 0 |
| Ingreso Mes 2 | $0 COP |
| Decisión | Re-evaluar producto, segmento o problema. No es fracaso — es aprendizaje |

---

## Reglas anti-trampa

- ❌ **No regalar Mes 2** "porque no quiero que se vaya". Regalar más mata el modelo de pago.
- ❌ **No bajar a $10.000** porque alguien lo pidió. Tomar dato y promediar al final del piloto.
- ❌ **No firmar plan anual** en Mes 2. Demasiada promesa con poca data.
- ❌ **No prometer descuentos a corto plazo** ("primer cliente paga 50% siempre"). Crea precedente difícil de revertir.
- ✅ **Sí cobrar Mes 2 en producción** aunque sean $29.990 de 1 piloto. Esa transacción es prueba de mercado.

---

## Lo que registramos durante Semanas 1-4

| Dato | Cómo |
|------|------|
| Para cada prospecto: rango de precio mencionado | Notas de call (P5 del [`05-guion-call-validacion.md`](05-guion-call-validacion.md)) |
| Para cada piloto: respuesta a escalera de precio Semanas 2-4 | Hoja Google Sheet (1 columna por semana) |
| Para cada piloto: respuesta final pago/no pago | Sheet + screenshot del mensaje |
| Pattern: ¿quién dice pagar el productor vs coop vs nadie? | Resumen narrativo en [`10-metricas-validacion.md`](10-metricas-validacion.md) |

---

## Decisión a tomar al cierre Semana 4

Con base en el patrón observado:

| Patrón observado | Decisión |
|-------------------|----------|
| ≥ 2 de 5 pilotos pagan $29.990 | Continuar con plan original. Empezar Phase 2 (cooperativas). |
| 1 de 5 pagaría $29.990 | Tibio. Validar más con 5 pilotos adicionales antes de pivotar. |
| 0 de 5 a precio $29.990 pero ≥ 3 a precio menor | Bajar precio a $14.990 y reintentar 1 mes. |
| 0 de 5 a cualquier precio individual, pero ≥ 3 dicen "lo pagaría la coop" | Pivote a B2B-via-coop. |
| 0 de 5 disposición clara | Pivote estructural. Revisar problema-solución. |

---

## Referencias

- Cómo se llega a la pregunta de pago: [`05-guion-call-validacion.md`](05-guion-call-validacion.md) Bloque 4
- Documento que formaliza commitment Mes 1: [`07-contrato-feedback-piloto.md`](07-contrato-feedback-piloto.md)
- KPIs y métricas: [`10-metricas-validacion.md`](10-metricas-validacion.md)
- Cronograma de cuándo escalar precio: [`09-cronograma-validacion-4-semanas.md`](09-cronograma-validacion-4-semanas.md)
