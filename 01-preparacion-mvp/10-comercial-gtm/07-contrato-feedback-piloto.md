# 07 - Contrato de Feedback para Piloto (1 página)

**Propósito**: documento corto, amigable, no-legal-pesado, que firman tú y el productor antes de iniciar el piloto gratuito de 4 semanas.

**No es un contrato de venta**. Es un acuerdo de colaboración para validación de producto.

**Por qué existe**:
- Filtra a quienes solo querían "ver gratis" sin comprometerse
- Establece expectativas claras desde el inicio
- Da estructura a las reuniones semanales
- Permite cerrar el piloto con honestidad al mes 1 sin presión de venta

---

## Plantilla del Contrato (copiar-pegar y personalizar)

```
─────────────────────────────────────────────────────────────────
ACUERDO DE COLABORACIÓN PARA PILOTO DE VALIDACIÓN
AgriTrace - Mes 1 (Validación gratuita)
─────────────────────────────────────────────────────────────────

Entre:

Diego Trujillo Rodríguez
Cédula: [tu cédula]
Email: diegotrujillor@gmail.com
("El equipo AgriTrace")

Y:

Nombre completo:    _______________________________________
Documento:          _______________________________________
Finca / Asociación: _______________________________________
Cultivo principal:  _______________________________________
Teléfono:           _______________________________________
Email:              _______________________________________
("El productor piloto")

─────────────────────────────────────────────────────────────────

PROPÓSITO:

El productor piloto recibirá acceso GRATUITO a la aplicación
AgriTrace durante 4 semanas, a cambio de proveer feedback honesto
sobre su utilidad. Este es un acuerdo de validación, no de venta.

─────────────────────────────────────────────────────────────────

DURACIÓN:

Inicio:        [fecha de inicio del piloto, YYYY-MM-DD]
Cierre:        [fecha de cierre, 4 semanas después, YYYY-MM-DD]

─────────────────────────────────────────────────────────────────

COMPROMISOS DEL PRODUCTOR PILOTO:

1. USO REAL: Registrar actividades reales de su finca en la
   aplicación al menos 2 veces por semana durante las 4 semanas.

2. REUNIÓN SEMANAL: Disponer de 15 minutos cada semana para una
   llamada de feedback con el equipo AgriTrace.

3. HONESTIDAD: Decir lo que funciona y lo que no funciona, sin
   filtros ni cortesías. El feedback negativo es más valioso que
   el positivo.

4. DECISIÓN AL CIERRE: Al final de las 4 semanas, responder con
   franqueza UNA pregunta: "¿Pagaría $29.990 COP al mes por
   continuar usando esta aplicación?" — sí, no, o "sí pero a otro
   precio (especificar)".

─────────────────────────────────────────────────────────────────

COMPROMISOS DEL EQUIPO AgriTrace:

1. ACCESO TOTAL: El productor recibe acceso completo al MVP
   durante las 4 semanas, sin restricciones funcionales.

2. SOPORTE: Atención por WhatsApp / llamada para resolver dudas
   técnicas o de uso, dentro de horario hábil (lun-vie 8am-6pm).

3. CONFIDENCIALIDAD: Los datos que el productor registre en la
   aplicación (siembras, cosechas, químicos, fotos) son del
   productor. AgriTrace NO los compartirá con terceros sin su
   permiso explícito por escrito.

4. SEGURIDAD: Los datos están protegidos con encriptación en
   tránsito (HTTPS) y en reposo (PostgreSQL en servidor en
   Colombia).

5. CIERRE LIMPIO: Si al final del mes el productor decide NO
   continuar, podrá descargar todos sus datos en formato PDF / CSV
   y sus datos en nuestro servidor serán eliminados a su solicitud.

─────────────────────────────────────────────────────────────────

LO QUE ESTE ACUERDO NO ES:

- NO es un contrato de compraventa.
- NO obliga al productor a pagar nada al final del mes.
- NO obliga al productor a continuar usando la aplicación.
- NO transfiere la propiedad intelectual de AgriTrace al productor.
- NO transfiere la propiedad de los datos del productor a AgriTrace.

─────────────────────────────────────────────────────────────────

QUÉ PASA AL FINAL DEL MES 1:

| Decisión del productor   | Qué sucede                                    |
|--------------------------|-----------------------------------------------|
| "Sí pago $29.990/mes"    | Continuamos con plan de pago mensual.         |
| "Sí pero a $X/mes"       | Negociamos precio o pivote.                   |
| "No pago, gracias"       | Cierre limpio. Datos exportados o eliminados. |
| "No respondo"            | Cierre por defecto al día 35.                 |

─────────────────────────────────────────────────────────────────

FIRMAS:

Diego Trujillo Rodríguez                Productor piloto

________________________                ________________________
Firma                                   Firma

Fecha: ____/____/______                 Fecha: ____/____/______

─────────────────────────────────────────────────────────────────

Una página. Sin letra pequeña. Sin abogados.
```

---

## Cómo enviarlo

**Opción A: WhatsApp (más rápido, menos formal)**

1. Convertir el texto arriba a PDF o imagen
2. Enviar por WhatsApp con mensaje:

```
[Nombre], como hablamos, te paso el documento que mencioné.

Es 1 página. Si estás de acuerdo, me pones tu firma (foto al
papel firmado o usando una app de firma) y me lo devuelves.

Cualquier duda me dices. ¿Te parece arrancar el piloto el
[fecha]?
```

**Opción B: Email (más formal, mejor para coop/gremio)**

```
Asunto: Acuerdo de piloto AgriTrace - 1 página

[Nombre], buen día.

Como conversamos, adjunto el acuerdo del piloto de 4 semanas.
Es corto, lo puede leer en 5 minutos.

Si está de acuerdo, lo firmamos los dos y arrancamos el
[fecha].

Quedo atento.

Diego Trujillo
AgriTrace
```

**Opción C: Firma digital (DocuSign, Firmamex, o similar)**

Para productores formalizados. Más profesional pero agrega fricción.
Solo usar si el productor lo pide o si es una cooperativa.

---

## Recomendaciones

- **Llevar varios formatos**: PDF, imagen JPG (algunos productores ven mejor en imagen), Word editable
- **Ofrecer leerlo juntos por teléfono** si el productor pregunta dudas
- **No firmes tú primero**: si tú firmas y luego él se demora, queda incómodo. Que firme él primero o ambos en simultáneo.
- **Si pide cambios**: probablemente sean cosméticos. Acepta con buen ánimo, refuerza confianza.
- **Si pide quitar la pregunta de pago**: red flag. Esa pregunta es el corazón del piloto. Insiste o descarta.

---

## Contraseña / acceso al MVP

Una vez firmado el contrato:

1. Crear cuenta en agritrace-backend (manual, mientras no exista onboarding pulido)
2. Enviar credenciales por canal seguro (NO email):
   - WhatsApp con mensaje efímero, o
   - Llamada telefónica (dictar)
3. Registrar acceso en hoja de pilotos:
   ```
   piloto_id, nombre, fecha_firma, fecha_acceso, cuenta_creada, primera_actividad_registrada
   ```
4. Confirmar primer registro en máximo 48h después del acceso (si no, llamar)

---

## Plantilla de email de bienvenida (después de firmar)

```
Asunto: Bienvenido al piloto AgriTrace - próximos pasos

[Nombre], gracias por confiar en nosotros.

Tu cuenta ya está lista. Te paso por WhatsApp las credenciales
en un momento.

Próximos pasos:

1. Hoy mismo: descarga la app desde [link Play Store / TestFlight]
2. En las próximas 48 horas: registra tu primera actividad
   (siembra, fumigación, riego, lo que sea real)
3. Si te enredas: me llamas o escribes a +57-XXX-XXX-XXXX
4. Próxima semana: yo te llamo para nuestro check-in semanal

Bienvenido al piloto.

Diego
```

---

## Referencias

- Cómo se llega a este punto: [`05-guion-call-validacion.md`](05-guion-call-validacion.md) Bloque 5 Caso A
- Pricing del mes 2: [`06-modelo-pricing-validacion.md`](06-modelo-pricing-validacion.md)
- Métricas a medir durante el piloto: [`10-metricas-validacion.md`](10-metricas-validacion.md)
- Análisis de "robo de idea" (cubierto por confidencialidad mutua): [`08-riesgo-robo-idea.md`](08-riesgo-robo-idea.md)
