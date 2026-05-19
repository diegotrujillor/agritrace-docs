# Métricas de validación — tracker local

Implementa `10-metricas-validacion.md` **sin Google Sheets** (opción
no-Google). 5 CSV (las 5 pestañas de entrada) + un generador del
"Reporte 1-pager". La pestaña `Resumen` la calcula el script, no es CSV.

## Archivos

| CSV | Pestaña | Grano (1 fila por…) |
|-----|---------|---------------------|
| `prospectos.csv` | Prospectos | contacto inicial (≤20) |
| `calls.csv` | Calls | call completada |
| `pilotos.csv` | Pilotos | piloto firmado |
| `pricing.csv` | Pricing | piloto × semana |
| `feedback.csv` | Feedback | feedback point |
| `generar-1pager.sh` | Resumen + 1-pager | script (no editar a mano) |

Cada CSV trae solo el encabezado — llenar filas a mano (o pegar desde
exportes). Validación de precio: la pregunta de disposición a pagar es
siempre la **tarifa full $29.900** (`pagaria_29900` = si/no).

## Generar el reporte 1-pager

```bash
cd 01-preparacion-mvp/10-comercial-gtm/data/metricas
./generar-1pager.sh                    # a pantalla
./generar-1pager.sh > reporte-$(date +%Y%m%d).txt
```

Calcula: prospectos contactados, tasa de respuesta, calls, pilotos
firmados/activos, pilotos que pagarían/no $29.900, dolor principal
(feedback objeción más repetido), feature más pedido, veredicto
(FUERTE/TIBIA/Pivote según `10-metricas` §"Decisión binaria"). Robusto
a CSV vacíos (devuelve 0 / `[pendiente]`).

## Automatizar (opcional, sin servicios externos)

Cron local semanal (lunes 9:00) que guarda el reporte:

```cron
0 9 * * 1 cd /ruta/a/.../data/metricas && ./generar-1pager.sh > reporte-$(date +\%Y\%m\%d).txt
```

## Migrar a Google Sheets (opcional, después)

Importar cada CSV como una pestaña; recrear `Resumen` con fórmulas
apuntando a las otras pestañas (umbrales verde/amarillo/rojo de
`10-metricas-validacion.md`). El tracker local sigue siendo la fuente
versionada.

## Privacidad / backups

`prospectos.csv` y `calls.csv` contienen datos personales de contactos.
Si se llenan con datos reales, **no commitear con PII** — mantener
encabezado en git y los datos reales fuera del repo (o gitignore de
`*-real.csv`). Política: Ley 1581 (ver `../../../08-legal/`).
