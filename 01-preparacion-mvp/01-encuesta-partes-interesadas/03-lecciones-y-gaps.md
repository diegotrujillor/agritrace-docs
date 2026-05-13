# 03 - Lecciones y Gaps de la Encuesta Inicial

**Estado**: ⚠️ La encuesta inicial tiene n=4. Esto es punto de partida, no validación concluyente.

**Fecha de análisis**: Mayo 2026

---

## Resumen de la encuesta original

- **Respondientes**: 4
- **Fecha de captura**: Octubre 2025
- **Método**: Formulario digital + entrevista informal

Resultados completos: [`02-encuesta-partes-interesadas-respuestas.md`](02-encuesta-partes-interesadas-respuestas.md).

---

## Lecciones extraídas (señales fuertes a pesar de n bajo)

| Hallazgo | Confianza | Impacto en MVP |
|----------|-----------|----------------|
| 4/4 dijeron que usarían app si funciona offline | Alta | Validó decisión de offline-first |
| 4/4 hoy registran en cuaderno/Excel/almanaque (NO en apps) | Alta | Confirma que el dolor existe |
| Trazabilidad y certificaciones aparecen como interés futuro pero no demanda actual | Media | Justifica diferir iteración futura (marketplace) |
| Conectividad: 1 de 4 NUNCA tiene conexión, 1 de 4 a veces, 2 de 4 siempre | Alta | Refuerza criticidad de offline |
| Disposición a pagar promedio: 2.25/5 (rango 1-3) | **BAJA** | Insuficiente para definir precio |
| Dispositivos mixtos: lapicero+cuaderno, computador portátil, celular básico | Media | Considerar SMS/USSD fallback (mantener en Should-Have) |

---

## Gaps reconocidos (n bajo + sesgo de muestra)

### Gap 1: Tamaño de muestra (n=4)

**Problema**: 4 respondientes no validan estadísticamente nada. Una respuesta puede mover el promedio drásticamente.

**Evidencia**: la pregunta "willingness to pay" tiene 1, 3, 2, 3 → promedio 2.25/5. Si hubiéramos tenido 1 respondiente con 5, promedio cambiaría a 2.8/5 (interpretación distinta).

**Mitigación**: el track comercial ([`../10-comercial-gtm/`](../10-comercial-gtm/)) prescribe **5-10 calls de validación adicionales en Semana 3** con productores específicos en Valle del Cauca. Estas calls reemplazan/refuerzan la encuesta.

### Gap 2: Sesgo de canal de captura

**Problema**: la encuesta original fue capturada por canales digitales y conocidos del founder. No representa al "productor pequeño promedio" del Valle del Cauca.

**Evidencia**: 2/4 respondientes usan computador portátil — no es perfil típico de pequeño productor rural en Valle.

**Mitigación**: el track comercial incluye **canal presencial (mercados, ferias)** que captura productores que no consumen contenido digital.

### Gap 3: Sin segmentación por cultivo

**Problema**: la encuesta no diferenció entre cultivos. Cacao, café, hortalizas, caña, frutas tienen necesidades distintas.

**Evidencia**: no hay forma de saber si el "willingness to pay 2.25" es uniforme o si productores de cacao (con presión EUDR) pagan más que paneleros.

**Mitigación**: la segmentación detallada en [`../10-comercial-gtm/01-icp-y-segmentacion.md`](../10-comercial-gtm/01-icp-y-segmentacion.md) prescribe distribución específica por cultivo y validación independiente por sub-segmento.

### Gap 4: Sin pregunta de "quién paga"

**Problema**: la encuesta no exploró modelo B2B (cooperativa paga) ni B2B2C (comprador paga). Asumió implícitamente que el productor paga directo.

**Evidencia**: ninguna pregunta sobre cooperativas, exportadores o subsidio.

**Mitigación**: el guion de call de validación ([`../10-comercial-gtm/05-guion-call-validacion.md`](../10-comercial-gtm/05-guion-call-validacion.md)) incluye explícitamente la pregunta P6: "¿Quién cree que sí pagaría?".

### Gap 5: Sin pregunta de "qué momento del año duele más"

**Problema**: el dolor de "no tener registros" puede ser cíclico (cosecha, certificación, comprador externo). Sin saber el momento, no sabemos cuándo el productor está más receptivo.

**Mitigación**: el guion de call incluye P5: "¿Hay momento del año en que pierde plata por no tener los registros bien?".

### Gap 6: Sin validación de UX

**Problema**: la encuesta no mostró interfaz, prototipo ni mockup. No sabemos si el diseño actual resuena.

**Mitigación**: los pilotos de 4 semanas incluyen calls semanales de feedback de UX (registrado en [`../10-comercial-gtm/10-metricas-validacion.md`](../10-comercial-gtm/10-metricas-validacion.md) §"Métricas blandas").

---

## Decisiones que NO se debe tomar solo con n=4

| Decisión candidata | Razón para esperar |
|---------------------|----------------------|
| Pricing definitivo ($X.XXX/mes) | Necesita 5-10 datos adicionales de willingness real |
| iteración futura marketplace prioridad | Encuesta dijo "no demanda" pero n=4 puede ocultar segmentos demandantes |
| Inversión en SMS fallback | 50% mencionó "celular básico" pero pequeño n |
| Canal preferido (FB vs WhatsApp vs Email) | Sin data confiable |

---

## Decisiones que SÍ se pueden tomar con n=4 (señales unánimes)

| Decisión | Razón |
|----------|-------|
| Offline-first es no-negociable | 4/4 unanimidad |
| App debe ser para productores (no buyers) en MVP | 4/4 hoy son productores |
| Pitch debe mencionar "registrar lo que pasa en la finca" | Cuaderno/Excel mentioned by 4/4 |
| Spanish only para MVP | 4/4 son colombianos |
| Diferir certificaciones como feature | 0/4 las tienen hoy |

---

## Acción recomendada

1. **No re-correr la encuesta** con esfuerzo de captura masiva (poco ROI).
2. **Reemplazarla con calls 1:1** de validación profunda durante Semanas 1-3 del track comercial ([`../10-comercial-gtm/09-cronograma-validacion-4-semanas.md`](../10-comercial-gtm/09-cronograma-validacion-4-semanas.md)).
3. **Capturar datos durante el piloto** (4 semanas de uso real) que valen más que cualquier encuesta retrospectiva.
4. **Re-evaluar al cierre del Mes 1 piloto** con datos de pago real (no autoreporte).

---

## Referencias

- Encuesta original (preguntas): [`01-encuesta-partes-interesadas.md`](01-encuesta-partes-interesadas.md)
- Respuestas de la encuesta: [`02-encuesta-partes-interesadas-respuestas.md`](02-encuesta-partes-interesadas-respuestas.md)
- Track comercial que reemplaza/refuerza la encuesta: [`../10-comercial-gtm/`](../10-comercial-gtm/)
- Métricas que validan estos gaps: [`../10-comercial-gtm/10-metricas-validacion.md`](../10-comercial-gtm/10-metricas-validacion.md)
