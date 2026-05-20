# Plantillas de comunicación — Sprint 5 (es-CO)

Mensajes listos para copiar-pegar a WhatsApp o email durante el piloto.
Reemplazar lo marcado entre `[ ]`.

---

## 1. Reclutamiento (1-a-1, antes del Día 0)

**WhatsApp / mensaje directo**

> Hola [Nombre], soy Diego. Estoy probando con 5 productores de
> [vereda/cooperativa] una app móvil para llevar finca, lotes y
> actividades (siembra, riego, cosecha) — funciona sin internet.
>
> ¿Te interesa probarla 1 mes (30 días)? Solo necesitas un celular Android.
> No tiene costo. Lo que más necesito es tu opinión real.
>
> Si te animas dime y te paso el link de instalación + nos vemos 30
> minutos (en persona o video) para arrancar.

---

## 2. Confirmar la sesión de onboarding (Día 0)

> Quedamos [día] a las [hora] para instalar AgriTrace en tu celular y
> crear tu cuenta. ~45 minutos.
>
> Antes de vernos:
> 1. Carga el celular.
> 2. Ten a la mano: nombre completo, correo y un teléfono con
>    indicativo (+57…).
> 3. Si puedes, conéctate a Wi-Fi para la descarga inicial.
>
> El link para instalar lo abrimos juntos:
> https://agritrace.co/#instalar

---

## 3. Bienvenida al grupo de WhatsApp (Día 0, post-onboarding)

> ¡Bienvenido al grupo del piloto AgriTrace 🌱!
>
> Aquí vamos a estar 1 mes (30 días). Reglas simples:
> • Cuenta cualquier cosa rara que veas en la app — captura de
>   pantalla si puedes.
> • Si la app se cierra sola, avisa: es importante.
> • Si una pantalla no se entiende, dilo así de claro — no hay
>   pregunta tonta.
> • Si no la pudiste abrir hoy, también dilo: nos sirve.
>
> Yo respondo entre semana 7am–7pm. Si es urgente (no abre, perdió
> datos), llámame.

---

## 4. Pulso diario (Días 1–13)

**Mensaje corto, mañana**

> Buenos días grupo 👋
> ¿Pudieron abrir AgriTrace ayer? ¿Algo raro?
> Si todo bien, mándenme 👍. Si algo raro, cuenten o manden captura.

**Mensaje corto, tarde si no contestaron**

> Pasando lista del piloto 🙋
> ¿Cómo va AgriTrace hoy? Cualquier detalle me sirve, no esperen a que
> sea grave.

---

## 5. Check-ins semanales (Días 7, 14, 21)

> Reutilizar la misma plantilla cada semana cambiando "1 semana" por
> "2 semanas" / "3 semanas". El check-in del Día 21 enfoca señales de
> Go/No-Go anticipado.

### Día 7 — primer check-in

> Llevamos 1 semana 🎉
> 3 preguntas cortas (responde con un número o una frase):
>
> 1) ¿Cuántos días de los 7 abriste la app?
> 2) ¿Qué pantalla te costó más?
> 3) ¿Algo que la app te debería avisar y no te avisa?

---

## 6. Hotfix release (cuando salga un fix mid-sprint)

> Actualización rápida de AgriTrace ⚙️
>
> Salió una versión que arregla [descripción corta del bug, sin jerga].
>
> Para actualizar:
> 1. Abre https://agritrace.co/#instalar
> 2. Toca el botón verde para descargar la nueva versión.
> 3. Cuando termine, tocas el archivo e instalas encima de la anterior
>    (no pierdes tu cuenta ni tus datos).
>
> Si no la actualizas, sigue funcionando — pero el fix solo lo tienes
> con la nueva.

---

## 7. Cierre del piloto + encuesta SUS (Día 30)

> ¡Llegamos al día 30! Gracias por aguantar el piloto 🙌
>
> Última cosa, 5 minutos máximo: 10 preguntas sobre qué tan fácil te
> pareció usar la app. Es anónimo y nos dice si esto ya sirve o
> necesita más ajustes antes de soltarlo a más gente.
>
> Link de la encuesta:
> [PEGAR URL DEL GOOGLE FORM]
>
> Después de que la llenes te confirmamos los próximos pasos.

---

## 8. Reporte de bug (si transcribo del WhatsApp a GitHub Issue)

Mensaje al tester confirmando que lo registré:

> Listo, ya lo anoté como tarea para arreglar 🛠️
> Si vuelve a pasar antes de que lo arregle, avísame igual — me sirve
> saber si es frecuente.

Para el issue (interno, Diego lo escribe en GitHub):

```
título: [bug] <resumen 1 línea>
labels: bug, sprint-5, field-test, P? (severidad)

Reportado por: [Nombre del tester en WhatsApp YYYY-MM-DD]
Dispositivo: [marca + modelo + Android version si se sabe]
Versión app: [1.3.X]
Conectividad: [con/sin internet]

Pasos: [lo que contó]
Esperado: [lo que iba a hacer]
Actual: [lo que pasó]
Captura: [adjuntar si la mandó]
```

---

## 9. Decisión Go/No-Go a Sprint 6 (Día 31)

**Si Go** (al grupo):

> El piloto cerró bien. ¡Gracias!
> Próximos pasos: [resumen de qué arreglamos + qué viene en Sprint 6].
> Pueden seguir usando la app — yo aviso cuando salga la próxima
> versión por aquí mismo.

**Si No-Go** (1-a-1, no al grupo):

> Hola [Nombre]. El piloto cerró y necesitamos un sprint extra para
> arreglar [tema]. La app sigue andando con lo que tienen, pero te
> aviso cuando saquemos la versión estable. Gracias por la paciencia
> — sin tu uso no habríamos detectado [cosa concreta].
