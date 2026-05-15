# 04 - Costos y Escalado

**Fecha**: Mayo 2026
**Versión**: 1.0
**Estado**: Aprobado para implementación
**Responsable**: Diego Trujillo
**Documento padre**: [01-decisiones-infra.md](01-decisiones-infra.md)

---

## 1. Resumen

Este documento modela los **costos actuales** del piloto, proyecta los **costos esperados** a medida que el número de usuarios crece y define los **triggers explícitos** que disparan migraciones a infraestructura más robusta. El objetivo es **decidir cuándo gastar más, no antes**.

> **Principio rector**: optimizar prematuramente cuesta dinero, complejidad y tiempo. Cada salto de stack está justificado por una métrica medible que se cumple **antes** de la migración, no después.

---

## 2. Costos Actuales (MVP Piloto: 0-50 usuarios)

| Concepto | Periodicidad | USD | COP aprox. | Notas |
|----------|--------------|-----|------------|-------|
| VM Oracle Cloud (Ampere A1, 4 OCPU + 24 GB RAM) | Mensual | $0 | $0 | Always-free |
| Oracle Object Storage 20 GB | Mensual | $0 | $0 | Always-free |
| Cloudflare DNS + Proxy + WAF básico | Mensual | $0 | $0 | Free plan |
| UptimeRobot Free (50 monitores) | Mensual | $0 | $0 | Free |
| Egress tráfico Oracle Free | Mensual | $0 | $0 | 10 TB/mes free, piloto usará < 1 GB |
| Dominio `agritrace.co` | Anual | ~$12 | ~$48.000 | Cloudflare Registrar at-cost |
| **Total mensual** | — | **$0** | **$0** | |
| **Total anual** | — | **~$12** | **~$48.000** | Solo dominio |

**Costo unitario**: $0 USD por usuario por mes (sin contar el dominio anual prorrateado: ~$0.02/usuario/mes con 50 usuarios).

---

## 3. Proyección de Costos por Rangos de Usuarios

Las cifras son **estimaciones** basadas en planes públicos de cada proveedor a la fecha del documento. Cada salto incluye margen de seguridad (~30%).

### 3.1 Tabla Maestra

| Rango usuarios activos | Etapa | Stack propuesto | Costo mensual USD | Costo unitario USD/usuario/mes |
|------------------------|-------|------------------|-------------------|-------------------------------|
| **0-50** | Piloto MVP | Oracle Free + Cloudflare Free + UptimeRobot Free | **$0** | $0.00 |
| **50-500** | Tracción inicial | Oracle Free + Cloudflare Free + Sentry Team + Healthchecks.io paid | **$20-30** | $0.04-0.06 |
| **500-2.000** | Crecimiento | Hetzner CX22 (€7) + Cloudflare Free + Sentry Team + Backblaze B2 backups | **$30-50** | $0.015-0.025 |
| **2.000-10.000** | Escala media | Hetzner dedicado o equivalent + Neon/Supabase Pro + Sentry Team + CDN | **$100-200** | $0.01-0.02 |
| **10.000-50.000** | Producto consolidado | Multi-VM con load balancer + Postgres managed + Redis managed + observability stack | **$500-1.500** | $0.01-0.03 |
| **50.000+** | Escala enterprise | Kubernetes managed, multi-región, RDS/Aurora, managed observability, edge CDN | **$3.000+** | Variable |

### 3.2 Detalle por Rango

#### 3.2.1 Rango 0-50 (Piloto MVP — actual)

Stack actual. Detalle completo en [`01-decisiones-infra.md`](01-decisiones-infra.md).

#### 3.2.2 Rango 50-500 (Tracción inicial)

**Cambios respecto al piloto**:

- **Sentry Team Plan** (~$26/mes): captura errores de la API y de la app móvil cuando el volumen de tickets manuales supera 5/semana.
- **Healthchecks.io paid** (~$5/mes): monitoreo activo de cron jobs (backup) con alertas SMS / Slack.
- Resto del stack se mantiene gratis: el VM Ampere A1 (24 GB RAM) tiene headroom de sobra para 500 usuarios.

**Disparadores típicos**:
- Más de 5 reportes de errores por semana detectados en logs manuales
- Necesidad de notificación de fallo de backup en tiempo real

#### 3.2.3 Rango 500-2.000 (Crecimiento)

**Cambios**:

- **Migración a Hetzner CX22** (€7.55/mes ~ $8 USD): se sale del free tier de Oracle ya sea porque (a) la VM Ampere se queda corta, (b) Oracle suspendió la cuenta, o (c) la auditoría Ley 1581 exige un proveedor con políticas más claras de transferencia internacional. Hetzner Helsinki/Falkenstein cumple GDPR + Ley 1581 con cláusulas modelo.
- **Backups a Backblaze B2** (~$0.005/GB/mes): se sale del tier gratis de Oracle Object Storage si éste se suspende junto con la cuenta. B2 cumple lifecycle policies y costo es trivial.
- **Cloudflare Pro** (opcional, $20/mes): WAF avanzado, image optimization, mejor cache. Solo si tráfico estático crece > 100 GB/mes.

**Disparadores típicos**:
- CPU sostenido del VM > 70% por > 24h
- Memoria > 80% por > 24h
- Oracle suspende cuenta (riesgo conocido del free tier)
- Costo de seguir en Oracle = lock-in en provider riesgoso supera ahorro de $0/mes

#### 3.2.4 Rango 2.000-10.000 (Escala media)

**Cambios**:

- **Postgres administrado** (Neon Pro $69/mes, Supabase Pro $25/mes, o Crunchy Bridge $35/mes): se libera la carga operacional (backups automáticos, replicación, point-in-time recovery, monitoreo). La DB del piloto en VM no escala bien sin tuning manual.
- **Hetzner dedicado** o equivalente (CX42, CCX13, AX series): el host de aplicación necesita más vCPUs para manejar más conexiones concurrentes.
- **CDN** (Cloudflare Free sigue, pero se añade Bunny.net o R2 para uploads si tráfico de fotos crece): la app móvil sirve más fotos.
- **Sentry sigue en Team**: 50k errores/mes cubren con holgura.

**Disparadores típicos**:
- Tamaño Postgres > 5 GB
- Conexiones concurrentes Postgres > 50
- Latencia API p95 > 500 ms en endpoints de read

#### 3.2.5 Rango 10.000-50.000 (Producto consolidado)

**Cambios**:

- **Múltiples VMs** con load balancer (Cloudflare LB o HAProxy en VM intermedia)
- **Postgres con réplicas read-only** o Neon Scale Plan
- **Redis managed** (Upstash, Redis Cloud)
- **Stack de observabilidad**: Grafana Cloud Free + Prometheus o Better Stack
- **CDN para uploads**: Cloudflare R2 con egress gratuito, integración nativa
- **CI/CD**: GitHub Actions paid o self-hosted runners

**Disparadores típicos**:
- 99.9% uptime SLA contractual con clientes empresa
- > 10k peticiones/minuto pico
- Equipo de desarrollo > 3 personas → necesidad de procesos formales

#### 3.2.6 Rango 50.000+ (Escala enterprise)

**Cambios**:

- **Kubernetes managed** (DigitalOcean Kubernetes, Linode LKE, EKS, GKE)
- **Aurora / Cloud SQL** o equivalente con réplicas multi-AZ
- **Multi-región** (LATAM + USA o EU)
- **Observabilidad enterprise**: Datadog, New Relic, o stack self-hosted en cluster
- **WAF avanzado** (Cloudflare Enterprise, AWS WAF)
- **SOC 2 / ISO 27001** compliance work

**Disparadores típicos**:
- Inversión recibida o revenue > $50k MRR
- Clientes empresa exigen contratos de SLA + auditoría de seguridad

---

## 4. Triggers de Migración (Concretos)

Cada trigger debe ser **medible**, **frecuente** y **resolutivo**. No migrar por intuición.

### 4.1 Tabla de Triggers

| # | Trigger | Métrica | Acción inmediata | ETA típica |
|---|---------|---------|------------------|-----------|
| T1 | **Backup falla 2+ veces consecutivas** | Exit code ≠ 0 en `backup-pg.sh` | Healthchecks.io paid + alertas SMS | 1 día |
| T2 | **CPU VM > 70% sostenido 24h** | `top` / Oracle metrics | Subir Ampere a 4 OCPU completas (si está en 1 OCPU) o evaluar migración | 1 semana |
| T3 | **Memoria VM > 80% sostenido 24h** | `free -h` / Oracle metrics | Tuning Postgres `shared_buffers` o subir RAM | 1 semana |
| T4 | **Cuenta Oracle suspendida** | Email Oracle o login fallido | Desplegar en Hetzner usando IaC reproducible | 4 horas |
| T5 | **Postgres DB > 5 GB** | `SELECT pg_database_size('agritrace_mvp')` | Migrar a Neon/Supabase Pro | 2 semanas |
| T6 | **Latencia API p95 > 500 ms** | Sentry performance o métricas Caddy | Identificar query lenta; índice; cache; o split DB | 1 semana |
| T7 | **> 5 errores/semana en logs** | Manual review semanal | Activar Sentry | 1 día |
| T8 | **Más de 1 deploy/semana** | git log frecuencia | Activar GitHub Actions CI/CD | 2 días |
| T9 | **> 1 contributor activo** | Identidades distintas en commits | Activar sops/age para secretos compartidos | 1 día |
| T10 | **Auditoría Ley 1581 (SIC) inicia** | Notificación oficial | Migrar a hosting Colombia (IFX, CAPACOL, Fly.io BOG) o documentar cláusulas modelo Oracle SP | 30 días (plazo legal típico) |
| T11 | **Tráfico egress > 5 TB/mes** | Oracle metrics | Cloudflare como CDN obligatorio o migración a R2 para uploads | 1 semana |
| T12 | **Requiere 99.9% SLA contractual** | Acuerdo con cliente | Multi-VM + load balancer + Postgres managed | 1 mes |

### 4.2 Reglas de Activación

- Un solo trigger activa la migración (no se requiere cumplir varios)
- La acción se documenta en bitácora de infraestructura (commit en `agritrace-infrastructure`)
- Si la migración tarda > ETA típica, escalar prioridad y considerar costo de oportunidad

---

## 5. Anti-patrones a Evitar

| Anti-patrón | Por qué duele | Alternativa |
|-------------|----------------|-------------|
| Migrar a Kubernetes "para estar listos" antes de 1.000 usuarios | Complejidad operacional 10x sin beneficio | Esperar a 10.000+ usuarios |
| Usar Postgres administrado desde el día 1 | $30+/mes innecesarios para 5 usuarios | Postgres en docker funciona bien hasta 100 usuarios |
| Multi-región antes de tener un solo cliente fuera de Colombia | Costos x3 + complejidad red | Una sola región hasta saturarla |
| Comprar Sentry Business Plan ($80/mes) en piloto | Manual log review semanal basta para 5 usuarios | Sentry Team ($26/mes) cuando errores > 5/semana |
| Cloudflare Enterprise ($200+/mes) por "seguridad" | Free WAF + Pro cubren > 99% de los casos | Subir a Pro solo si bot abuse confirmado |
| Reservar dominio premium ($500+) en piloto | Capital muerto si producto pivota | `.co` o `.com.co` (~$12/año) hasta validación comercial |
| Comprar tarjeta de crédito empresarial con $10k de límite "por si" | Tentación a gastar | Tarjeta personal con límite bajo durante validación |

---

## 6. Comparación de Cloud Providers (Referencia)

Tabla orientativa para el momento de migración. **No es compromiso**, solo benchmarks públicos a la fecha.

| Provider | VPS ~$5/mes | VPS ~$20/mes | Postgres administrado | Object Storage | Egress incluido |
|----------|-------------|--------------|----------------------|----------------|------------------|
| **Hetzner** | CX22 (€7.55, 2 vCPU, 4 GB) | CX42 (€17, 8 vCPU, 16 GB) | No (DIY) | Storage Box ~€3/TB | 20 TB |
| **Oracle Free** | A1.Flex Always Free (24 GB RAM) | Mismo (free) | No (DIY) | 20 GB free | 10 TB |
| **DigitalOcean** | $6 Droplet (1 vCPU, 1 GB) | $24 (4 vCPU, 8 GB) | $15 Managed | $5/250GB Spaces | 1-5 TB |
| **Vultr** | $6 (1 vCPU, 1 GB) | $24 (4 vCPU, 8 GB) | $20 Managed | $5/250GB | 1-5 TB |
| **Linode (Akamai)** | $5 Nanode | $24 (4 vCPU, 8 GB) | $60 Managed Postgres | $5/250GB | 1-5 TB |
| **AWS Lightsail** | $5 (1 vCPU, 1 GB) | $24 (4 vCPU, 8 GB) | $15 RDS Lightsail | $1/GB-mo S3 | Variable |
| **AWS EC2** | t3.micro (~$8) | t3.medium (~$30) | RDS desde $15 | S3 desde $0.023/GB-mo | $0.09/GB egress |
| **GCP Compute** | e2-micro (~$8) | e2-medium (~$25) | Cloud SQL desde $15 | GCS desde $0.020/GB-mo | $0.12/GB egress |
| **Fly.io** | shared-cpu-1x (~$5) | performance-2x (~$30) | Fly Postgres incluido | Tigris Object Storage | 100 GB |
| **Render** | $7 Starter | $25 Standard | $7 Postgres Starter | S3-compatible | Limitado |
| **Cloudflare Workers** | $5 Workers Paid | Variable | D1 + R2 | R2 ($0.015/GB-mo, egress free) | Free egress |

**Notas**:
- AWS/GCP tienen el egress más caro — riesgoso para apps con muchas fotos
- Hetzner gana en relación precio/recursos pero está en Europa
- Cloudflare R2 destaca por egress free (ideal para uploads)
- Fly.io tiene región Bogotá (BOG) — única opción "Colombia nativa" mainstream

---

## 7. Sensibilidad al Tipo de Cambio (USD/COP)

El proyecto cobra en COP a productores pero paga infra en USD. Monitorear:

- **Costo mensual USD × tasa TRM** del día → COP gastados
- Si COP se devalúa > 10% en 30 días, considerar:
  - Prepago anual de planes que ofrecen descuento (~10-15% típicamente)
  - Migración a Cloudflare R2 (cobro en USD pero costo menor que S3)

Tabla de sensibilidad para costos típicos:

| Costo USD/mes | TRM 4.000 COP | TRM 4.500 COP | TRM 5.000 COP |
|---------------|---------------|---------------|---------------|
| $30 (50-500 users) | $120.000 | $135.000 | $150.000 |
| $100 (2.000 users) | $400.000 | $450.000 | $500.000 |
| $500 (10.000 users) | $2.000.000 | $2.250.000 | $2.500.000 |

---

## 8. Costos NO incluidos en este modelo

Los siguientes costos están **fuera del alcance** de este documento pero existen y se documentan aparte:

- **Stripe / PayU** o pasarela de pago (cuando se active): 3-4% + COP $900 por transacción
- **Email transaccional** (Resend, SendGrid, Mailgun): ~$10-20/mes para piloto, escala con volumen
- **SMS gateway** (Twilio, Vonage): ~$0.02-0.05 por SMS para fallback OTP/alertas
- **Servicios legales** (abogado para Ley 1581, contratos): no recurrente
- **Apple Developer + Google Play** (cuando se publique app): $99/año iOS, $25 one-time Android
- **Salarios y contratistas**: capa de costo principal, fuera del scope técnico

---

## 9. Vínculo con la Validación Comercial

El track comercial ([`../10-comercial-gtm/`](../10-comercial-gtm/)) define el plan de pricing piloto:

- **Mes 1 gratis** con commitment contract
- **Mes 2+ = $29.990 COP/mes** por productor

Equivalencias clave:

| Métrica | Valor |
|---------|-------|
| **Pago/usuario/mes** | $29.990 COP ≈ $7.50 USD |
| **Costo unitario MVP infra** | $0.00/usuario/mes |
| **Costo unitario rango 500-2.000** | $0.015-0.025/usuario/mes |
| **Margen bruto infra @ 100 usuarios** | $7.50 - $0.20 = $7.30 USD/usuario (97% margen sobre infra) |

> **Conclusión**: el costo de infraestructura **nunca** es el cuello de botella económico del piloto. Los costos relevantes son los humanos (Diego full-time, eventual contratista UX) y de adquisición de cliente (visitas a fincas, gasolina, tiempo).

---

## 10. Definición de "Done"

- [ ] Costos del piloto (rango 0-50) verificados con factura real (cuenta Oracle)
- [ ] Triggers T1-T12 listados en bitácora de operaciones
- [ ] Procedimientos de migración para T4 (Oracle suspende) y T5 (DB > 5 GB) probados o documentados paso a paso
- [ ] Calendario mensual para revisar métricas (CPU, RAM, DB size) — primer lunes de cada mes
- [ ] Hoja de cálculo o documento con costos reales mes a mes (mínimo Excel)
- [ ] Sensibilidad TRM revisada al cambiar de tramo

---

## 11. Referencias

- Decisiones de infraestructura: [`01-decisiones-infra.md`](01-decisiones-infra.md)
- Topología: [`02-topologia.md`](02-topologia.md)
- Secretos y backups: [`03-secretos-y-backups.md`](03-secretos-y-backups.md)
- Pricing comercial: [`../10-comercial-gtm/06-modelo-pricing-validacion.md`](../10-comercial-gtm/06-modelo-pricing-validacion.md)
- Métricas validación: [`../10-comercial-gtm/10-metricas-validacion.md`](../10-comercial-gtm/10-metricas-validacion.md)
- Pricing pages: oracle.com/cloud/free, hetzner.com/cloud, neon.tech/pricing, supabase.com/pricing, sentry.io/pricing, cloudflare.com/plans
