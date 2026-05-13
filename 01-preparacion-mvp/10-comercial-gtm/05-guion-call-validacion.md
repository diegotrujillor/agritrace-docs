# 05 - Guión de Call de Validación (no de venta)

**Objetivo**: estructura completa para una llamada de 15-30 minutos cuyo único propósito es **aprender**, no cerrar venta.

**Audiencia**: prospecto que ya aceptó la call de 15 min después del [pitch de 30 segundos](03-pitch-30s-y-2min.md).

**Duración objetivo**: 20-30 minutos (puede extenderse si el productor está enganchado).

---

## Mantra antes de la call

> No vengo a vender. Vengo a aprender.
> Si al final tengo un piloto comprometido, bien.
> Si no, también sirvió: aprendí.

---

## Estructura de la call (5 bloques)

| Bloque | Tiempo | Objetivo |
|--------|--------|----------|
| 1. Apertura y contexto | 2-3 min | Romper hielo, explicar que es validación no venta |
| 2. Preguntas de descubrimiento | 5-8 min | Entender cómo trabaja hoy (sin mencionar AgriTrace todavía) |
| 3. Pitch de 2 minutos + demo | 5-8 min | Mostrar la app/demo, explicar concepto |
| 4. Preguntas de validación | 5-8 min | Feedback honesto + willingness-to-pay + commitment |
| 5. Cierre y próximos pasos | 2-3 min | Definir si hay piloto o no |

---

## Bloque 1: Apertura y contexto (2-3 min)

```
Hola [nombre], gracias por darme estos minutos.

[Si aplica disclaimer de disartria]:
Antes de empezar: a veces me como alguna palabra sin querer, es una
secuela leve. Si pasa, repito y seguimos. ¿Vale?

Antes que nada quiero ser claro: esta llamada no es para venderle
nada. Yo construí AgriTrace y necesito aprender de productores
reales si esto sirve o no. Su feedback honesto vale más para mí
que cualquier "sí" por compromiso.

¿Podemos empezar?
```

**Por qué funciona**:
- Quita la guardia del prospecto (no es vendedor)
- Pide permiso (control compartido)
- Posiciona feedback como valioso (lo es)

---

## Bloque 2: Preguntas de descubrimiento (5-8 min)

**Regla de oro**: 80% escuchar, 20% hablar. Tomar notas.

```
Antes de mostrarle nada, cuénteme un poco:

1. ¿Qué cultivo manejan ustedes principalmente?

2. ¿Cuántas hectáreas?

3. Cuando hace una actividad en la finca —siembra, fumigación,
   cosecha— ¿cómo la registra hoy? ¿En cuaderno, almanaque,
   memoria, Excel?

4. ¿Le ha pasado que un comprador le pida pruebas de cómo cultivó,
   qué químicos usó, fechas exactas? ¿O todavía no?

5. ¿Hay momento del año en que pierde plata por no tener
   los registros bien? Por ejemplo: vender más barato, no poder
   exportar, perder un cliente.

6. ¿Conectividad en su finca: tiene buena señal? ¿O zona muerta?
```

**Notas importantes**:
- **No respondas tú** sus preguntas durante este bloque. Si hace una pregunta, contesta corto y vuelve a preguntar.
- **Anota textualmente** frases del productor (luego son oro para iterar pitch).
- Si menciona problemas que tu MVP NO resuelve, anótalo. Es validación de iteración futura.

---

## Bloque 3: Pitch de 2 minutos + demo (5-8 min)

**Transición**:

```
Lo que me cuenta es exactamente lo que hemos visto. Le explico
en 2 minutos qué construimos y le muestro:

[Decir el pitch de 2 minutos del documento 03]
```

**Mostrar demo**:

1. Compartir pantalla (Google Meet, Zoom) o enviar link de [`agritrace-demo`](https://github.com/diegotrujillor/agritrace-demo) si call telefónica
2. Recorrer 3 pantallas máximo (no las 10):
   - Login + Dashboard con fincas
   - Vista lote + timeline de actividades ⭐ (la más importante)
   - Registrar actividad
3. **Mostrar offline**: bajar wifi, registrar una actividad, mostrar que se guardó
4. **No vender features**: mostrar y callar. Que él pregunte.

**Si pregunta sobre algo que NO está en MVP**:

```
Buena pregunta. Eso lo tenemos en iteración futura [/ próximamente / aún
no está]. Por ahora el MVP se enfoca en registrar actividades.
¿Eso le serviría primero, o sin lo otro no le sirve?
```

---

## Bloque 4: Preguntas de validación (5-8 min)

**Las 6 preguntas oro**:

```
1. Honestamente, ¿esto le serviría en su finca?
   ¿Qué le falta? ¿Qué le sobra?

2. ¿Qué es lo que más le llamó la atención?

3. ¿Y qué le pareció raro o complicado?

4. Si esto estuviera listo en 1 mes y le diéramos 1 mes gratis
   para probarlo en su finca, ¿lo usaría? Sí o no.

5. Si después de ese mes le pidiéramos $29.990 pesos al mes,
   ¿lo seguiría usando? ¿O al precio de $10.000? ¿O cero?

6. Si usted no pagara, ¿quién cree que sí pagaría? ¿La cooperativa?
   ¿El comprador? ¿La alcaldía? ¿Nadie?
```

**Cómo manejar cada respuesta**:

| Respuesta a P4 | Significado | Próximo paso |
|----------------|-------------|--------------|
| "Sí" rotundo | Candidato a piloto fuerte | Bloque 5: ofrecer commitment contract |
| "Tal vez" / "Habría que ver" | Tibio, probable que no use | Pregunta qué le falta para ser "sí" |
| "No, no me sirve" | Honesto, no es tu cliente | Agradece + pide referido + cierra |

| Respuesta a P5 | Significado | Acción |
|----------------|-------------|--------|
| "Sí pago $29.990" | Modelo validado | Anotar y celebrar internamente |
| "Sí pero $10.000 max" | Sensibilidad de precio | Anotar; ver patrón con otros |
| "No pago, debería ser gratis" | No paga directo | Pregunta P6 (¿quién paga?) |
| Silencio / evasiva | Probablemente no paga | No insistir, anotar como "willingness baja" |

| Respuesta a P6 | Significado | Acción |
|----------------|-------------|--------|
| "La cooperativa" | Modelo B2B-via-coop validado | Pedir contacto en la coop |
| "El comprador" | Modelo B2B2C validado | Anotar; explorar iteración futura |
| "Nadie pagaría" | Producto no tiene mercado a este precio | Reflexionar después |

---

## Bloque 5: Cierre y próximos pasos (2-3 min)

### Caso A: hay interés en piloto

```
Perfecto. Lo que propongo es lo siguiente:

Le doy acceso gratis al MVP por 1 mes. A cambio, necesito tres
compromisos pequeños:

1. Que use la app al menos 2 veces por semana, registrando
   actividades reales de su finca.

2. Una llamada corta de 15 minutos cada semana para que me cuente
   qué funciona y qué no.

3. Al final del mes, me dice honestamente: "sí pagaría $29.990"
   o "no, no pagaría". Sin compromiso de pago, solo honestidad.

Le envío un documento corto de 1 página que firmamos los dos
(es solo para formalizar feedback, no es contrato de pago).

¿Le parece?
```

Si dice **sí**: enviar [`07-contrato-feedback-piloto.md`](07-contrato-feedback-piloto.md) por email/WhatsApp en las próximas 24h.

### Caso B: no hay interés en piloto pero hay feedback

```
Le agradezco mucho la honestidad. Esto me sirve más que un "sí"
por compromiso.

Una última cosa: ¿conoce algún productor en su zona o en su
asociación a quien sí le podría servir? ¿Me podría compartir
su contacto?
```

Anotar referido en [`04-lista-contactos-20.md`](04-lista-contactos-20.md) como nuevo prospecto.

### Caso C: no fit total

```
Entiendo. Le agradezco mucho su tiempo. Si en algún momento
quiere ver cómo evoluciona, le aviso. ¿Le parece bien que le
escriba en 6 meses?
```

Marcar como `descartado` con razón en notas.

---

## Toma de notas durante la call

**Plantilla post-call** (llenar en los 10 min siguientes a colgar):

```
Fecha: YYYY-MM-DD
Prospecto: [nombre, organización, cultivo]
Duración real: XX min

DOLOR PRINCIPAL (cita textual):
"..."

REACCIÓN AL PRODUCTO:
- Le gustó: [...]
- Le confundió: [...]
- Le faltó: [...]

WILLINGNESS-TO-PAY:
- $0: [sí/no]
- $10.000: [sí/no]
- $29.990: [sí/no]
- ¿Quién pagaría?: [productor / coop / comprador / nadie]

DECISIÓN:
- [ ] Piloto comprometido (firmar contrato feedback)
- [ ] Tibio, follow-up en 1 semana
- [ ] No fit, descartar
- [ ] No fit pero dio referido(s): [nombres]

PRÓXIMA ACCIÓN:
[concreta, con fecha]

CITAS TEXTUALES PARA AJUSTAR PITCH:
"..."
"..."
```

---

## Manejo de objeciones comunes

### "No tengo tiempo para registrar nada en una app"
```
Le entiendo. La idea es que sea más rápido que el cuaderno: 30
segundos por actividad. Si después de 1 semana le toma más, lo
dejamos. No quiero que pierda tiempo.
```

### "No tengo buena señal en la finca"
```
Por eso la app funciona sin internet. Usted registra, se guarda
en el celular, y cuando llega a un sitio con señal se sincroniza
solo. ¿Le sirve eso?
```

### "Eso es para fincas grandes, no para mí"
```
Al revés. Las fincas grandes ya tienen sistemas. AgriTrace está
hecho para finca pequeña que hoy lleva todo en cuaderno. Es
exactamente para usted.
```

### "Y si me roban la información?"
```
Buena pregunta. Los datos están en su celular, encriptados, y
en nuestro servidor en Colombia. No los compartimos sin su
permiso. ¿Le mando la política de datos?
```

### "Mejor cuando esté lista esa función [X]"
```
Justamente por eso le pregunto ahora: si X es lo que más necesita,
me sirve saberlo para priorizar. ¿X o registrar actividades, qué
le sirve más primero?
```

---

## Después de cada call (rituales)

1. **Llenar plantilla post-call** (10 min)
2. **Actualizar Google Sheet** de contactos: cambiar `status` y agregar notas
3. **Decisión binaria en 24h**:
   - ¿Comprometido? → Enviar contrato feedback
   - ¿Tibio? → Follow-up al día 7
   - ¿No fit? → Mover a `descartado` y olvidar
4. **Compartir aprendizajes con esposa** (15 min): qué funcionó del pitch, qué cambiar

---

## Anti-patrones en la call

- ❌ Hablar más del 30% del tiempo total
- ❌ Defender la app cuando dan feedback negativo (anota, no defiendas)
- ❌ Prometer features que no existen
- ❌ Saltar al pricing antes de mostrar la app
- ❌ Insistir si dijeron "no" claro
- ❌ Olvidar pedir referidos cuando no hay fit

---

## Referencias

- Pitches: [`03-pitch-30s-y-2min.md`](03-pitch-30s-y-2min.md)
- Pricing detallado: [`06-modelo-pricing-validacion.md`](06-modelo-pricing-validacion.md)
- Contrato a enviar después: [`07-contrato-feedback-piloto.md`](07-contrato-feedback-piloto.md)
- Métricas a registrar: [`10-metricas-validacion.md`](10-metricas-validacion.md)
- Cronograma: [`09-cronograma-validacion-4-semanas.md`](09-cronograma-validacion-4-semanas.md)
