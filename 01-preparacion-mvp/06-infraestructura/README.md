# 06 - Infraestructura

Esta sección documenta las decisiones, topología y procedimientos de infraestructura para el despliegue del MVP de AgriTrace.

## Filosofía

> **"Hacer lo mínimo que funcione hoy; añadir herramientas solo cuando el dolor las justifique."**

La infraestructura del MVP prioriza **costo cero**, **simplicidad operativa** y **time-to-market**, sobre redundancia, alta disponibilidad y compliance avanzado, los cuales se atenderán en iteraciones futuras una vez validada la tracción comercial.

## Documentos

| # | Documento | Estado | Descripción |
|---|-----------|--------|-------------|
| 01 | [Decisiones de Infraestructura](01-decisiones-infra.md) | ✅ Aprobado | Proveedor, stack mínimo, costos, compliance, riesgos |
| 02 | `02-topologia.md` | 🔲 Pendiente | Diagrama de topología y flujo de tráfico |
| 03 | `03-secretos-y-backups.md` | 🔲 Pendiente | Gestión de `.env`, rotación, política de backups |
| 04 | `04-costos-y-escalado.md` | 🔲 Pendiente | Modelado de costos y triggers de migración |

## Resumen del Stack

- **Compute**: Oracle Cloud Free Tier VM (Ampere A1, 4 OCPU + 24 GB RAM, São Paulo)
- **Runtime**: Docker + Docker Compose
- **Servicios**: PostgreSQL 15, Redis 7, agritrace-backend (Node.js), Caddy (reverse proxy + SSL)
- **DNS / Edge**: Cloudflare Free (DNS + proxy + WAF básico)
- **Seguridad host**: `ufw` + `fail2ban` + SSH endurecido
- **Backups**: `pg_dump` diario → Oracle Object Storage
- **Monitoring**: UptimeRobot externo (free)

**Costo total**: $0/mes + ~$12 USD/año (solo dominio).

## Repositorio de Implementación

La implementación concreta (scripts, `Caddyfile`, `docker-compose.yml` de producción, jobs de backup) reside en el repositorio [`agritrace-infrastructure`](https://github.com/diegotrujillor/agritrace-infrastructure).

## Lectura Recomendada

1. Comienza con [`01-decisiones-infra.md`](01-decisiones-infra.md) para entender el porqué de cada elección
2. Luego revisa los documentos 02-04 cuando estén disponibles
3. Para implementar, ve al repositorio `agritrace-infrastructure`
