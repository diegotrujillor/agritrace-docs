# Encuesta SUS-10 — AgriTrace (es-CO)

System Usability Scale (J. Brooke, 1996). 10 afirmaciones, escala
Likert 1–5. Estándar para evaluar usabilidad; meta del MVP es **>60**
(`09-scope-mvp.md §6`).

> Copiar este contenido a Google Forms / Tally / Typeform al Día 30 y
> enviar el link por WhatsApp (plantilla §7 en
> [`03-comms-templates-es-CO.md`](03-comms-templates-es-CO.md)).

---

## Instrucciones para el tester (mostrar al inicio del form)

> Responde con qué tan de acuerdo estás con cada frase, pensando en
> cómo te fue usando AgriTrace estos 30 días.
>
> **1 = Totalmente en desacuerdo · 5 = Totalmente de acuerdo**
>
> No hay respuestas correctas. Si una frase no aplica a tu uso, marca
> el número del medio (3). Responde con tu impresión, no lo pienses
> mucho.

---

## Las 10 preguntas (idénticas al SUS estándar, traducidas)

Cada una con escala 1–5 (radio o linear scale en Google Forms).

| # | Pregunta | Polaridad |
|---|---|---|
| 1 | Creo que me gustaría usar AgriTrace con frecuencia. | + |
| 2 | Encontré AgriTrace innecesariamente complicada. | − |
| 3 | Pensé que AgriTrace era fácil de usar. | + |
| 4 | Creo que necesitaría apoyo de una persona técnica para poder usar AgriTrace. | − |
| 5 | Las distintas funciones de AgriTrace estaban bien integradas. | + |
| 6 | Pensé que había demasiada inconsistencia en AgriTrace. | − |
| 7 | Imagino que la mayoría de la gente aprendería a usar AgriTrace muy rápido. | + |
| 8 | Encontré AgriTrace muy incómoda de usar. | − |
| 9 | Me sentí seguro/confiado usando AgriTrace. | + |
| 10 | Necesité aprender muchas cosas antes de poder usar AgriTrace. | − |

---

## Cómo se calcula el puntaje SUS

Para **cada respondedor** (no para cada pregunta):

1. **Impares (1, 3, 5, 7, 9)** → restar **1** al valor marcado.
   Ej: 4 → 3.
2. **Pares (2, 4, 6, 8, 10)** → restar al **5** el valor marcado.
   Ej: 2 → 5 − 2 = 3.
3. **Sumar** los 10 valores ajustados (rango 0–40).
4. **Multiplicar por 2.5** → puntaje SUS individual (0–100).

**Puntaje global del piloto** = promedio (media) de los puntajes
individuales.

### Tabla de interpretación (Sauro & Lewis, 2011)

| SUS | Lectura |
|---|---|
| ≥85 | Excelente |
| 72–84 | Bueno |
| 52–71 | OK / aceptable |
| **>60** | **Meta MVP** (`09-scope-mvp.md`) |
| 38–51 | Pobre — requiere rediseño |
| <38 | Inaceptable |

---

## Sección extra (opcional, fuera del SUS estándar)

Al final del Form añadir 3 preguntas abiertas que NO afectan el SUS
pero capturan señal cualitativa:

1. **¿Qué fue lo que más te gustó de AgriTrace?** _(texto libre)_
2. **¿Qué fue lo más frustrante?** _(texto libre)_
3. **¿Cambiaría algo para que la usaras todos los días?** _(texto libre)_

Y un campo final:

4. **¿Te interesaría seguir usando AgriTrace cuando salga la versión estable?**
   - Sí, sin dudar
   - Sí, depende del precio
   - Tal vez
   - No por ahora

---

## Plantilla rápida de cálculo (Google Sheets)

Si los datos del Form se exportan a Sheets, columna por respondedor:

```
=((B2-1)+(5-B3)+(B4-1)+(5-B5)+(B6-1)+(5-B7)+(B8-1)+(5-B9)+(B10-1)+(5-B11))*2.5
```

Donde `B2..B11` son las respuestas 1..10 de un mismo tester.
El SUS global del piloto es el `=PROMEDIO()` de la columna de
puntajes individuales.

---

## Notas

- SUS es **un instrumento global**, no diagnóstico por pregunta. No
  conviene reportar resultados pregunta-a-pregunta a los testers, solo
  el puntaje global.
- N=5 es estadísticamente débil pero suficiente para detectar
  problemas mayores de usabilidad (Nielsen, 1993).
- Aplicar el SUS **una sola vez al final** (no a mitad de piloto)
  para evitar fatiga.
