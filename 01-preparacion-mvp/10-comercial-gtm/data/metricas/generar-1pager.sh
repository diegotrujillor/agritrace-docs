#!/usr/bin/env bash
#
# AgriTrace — generador local del "Reporte 1-pager" de validación MVP.
# Lee los CSV de esta carpeta (prospectos/calls/pilotos/pricing/feedback)
# y emite el reporte de 10-metricas-validacion.md (§ "Reporte 1-pager")
# con los números duros calculados. Sin dependencias (bash + awk).
#
# Uso:
#   ./generar-1pager.sh                 # imprime a stdout
#   ./generar-1pager.sh > reporte.txt   # guarda
#
# Robusto a CSV solo-encabezado (devuelve 0 / [pendiente]).
# Nota: campos con comas deben ir entre comillas; el conteo simple
# asume cita_textual sin comas sin comillas — usar comillas si las hay.

set -euo pipefail
cd "$(dirname "$0")"

# filas de datos (excluye encabezado y líneas vacías)
rows() { tail -n +2 "$1" 2>/dev/null | grep -cve '^[[:space:]]*$' || true; }
# cuenta filas cuyo campo $2 (1-based) == valor $3 (case-insensitive)
countf() {
  tail -n +2 "$1" 2>/dev/null | awk -F, -v c="$2" -v v="$3" \
    'tolower($c)==tolower(v){n++} END{print n+0}'
}
pct() { awk -v a="$1" -v b="$2" 'BEGIN{printf (b>0)? "%d" : "0", (b>0)?a*100/b:0}'; }

PROS=$(rows prospectos.csv)
RESP=$(( $(countf prospectos.csv 11 agendado) + $(countf prospectos.csv 11 completado) ))
TASA=$(pct "$RESP" "$PROS")
CALLS=$(rows calls.csv)
PILOTOS=$(rows pilotos.csv)
ACTIVOS=$(tail -n +2 pilotos.csv 2>/dev/null | awk -F, '$6+0>=1{n++} END{print n+0}')
PAGAN=$(tail -n +2 pricing.csv 2>/dev/null \
  | awk -F, 'tolower($5)=="si"{p[$1]=1} END{print length(p)+0}')
NOPAGAN=$(tail -n +2 pricing.csv 2>/dev/null \
  | awk -F, 'tolower($5)=="no"{p[$1]=1} END{print length(p)+0}')

dolor=$(tail -n +2 feedback.csv 2>/dev/null \
  | awk -F, 'tolower($3)=="objecion"{print $4}' | sort | uniq -c | sort -rn \
  | head -1 | sed -E 's/^ *[0-9]+ //')
[ -z "${dolor:-}" ] && dolor="[pendiente — registrar feedback tipo=objecion]"
feat=$(tail -n +2 feedback.csv 2>/dev/null \
  | awk -F, 'tolower($3)=="feature"{print $4}' | sort | uniq -c | sort -rn \
  | head -1 | sed -E 's/^ *([0-9]+) /(\1×) /')
[ -z "${feat:-}" ] && feat="[pendiente — registrar feedback tipo=feature]"

# Veredicto (10-metricas-validacion.md §"Decisión binaria")
if   [ "$PAGAN" -ge 2 ]; then VER="Validación FUERTE"
elif [ "$PAGAN" -eq 1 ]; then VER="Validación TIBIA — revisar pricing"
elif [ "$NOPAGAN" -gt 0 ]; then VER="Pricing alto / Pivote — nadie paga full"
else VER="[pendiente — sin datos de pricing]"; fi

cat <<EOF
─────────────────────────────────────────────────────
AgriTrace - Reporte Validación MVP
Fecha: $(date +%Y-%m-%d)
─────────────────────────────────────────────────────

NÚMEROS DUROS
- Prospectos contactados: ${PROS}/20
- Tasa de respuesta: ${TASA}%
- Calls completadas: ${CALLS}
- Pilotos firmados: ${PILOTOS}
- Pilotos activos al cierre: ${ACTIVOS}
- Pilotos que pagarían \$29.900: ${PAGAN}
- Pilotos que NO pagarían \$29.900: ${NOPAGAN}

DOLOR PRINCIPAL VALIDADO
"${dolor}"

FEATURE MÁS PEDIDO (iteración futura)
${feat}

VEREDICTO
${VER}

ACCIÓN PARA PRÓXIMOS 30 DÍAS
1. [completar manualmente]
2. [completar manualmente]
3. [completar manualmente]

─────────────────────────────────────────────────────
EOF
