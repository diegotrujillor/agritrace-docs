# 01 - Decisiones de Infraestructura (MVP Piloto)

**Fecha**: Mayo 2026
**Versión**: 1.0
**Estado**: Aprobado para implementación
**Responsable**: Diego Trujillo
**Alcance**: Infraestructura mínima para piloto de 5 agricultores en Valle del Cauca

---

## 1. Contexto y Restricciones

Este documento captura las decisiones de infraestructura que regirán el despliegue del MVP de AgriTrace durante la fase de validación con el piloto comercial. Las decisiones priorizan **costo cero**, **simplicidad operativa** y **time-to-market**, sobre redundancia, escalabilidad y compliance avanzado, los cuales se atenderán en iteraciones futuras una vez validada la tracción.

### 1.1 Restricciones del MVP

| Restricción | Valor | Implicación |
|-------------|-------|-------------|
| **Presupuesto operacional** | ≈ $0/mes USD | Forzar uso de tiers gratuitos perpetuos. Único costo aceptable: dominio (~$10-15 USD/año). |
| **Escala esperada** | 5 agricultores piloto, ~50 actividades/día, sync intermitente | No requiere alta disponibilidad, clúster, ni autoscaling. Una sola VM suficiente. |
| **Equipo operativo** | 1 desarrollador (Diego) | Stack debe ser autoservicio, sin SRE dedicado. |
| **Time-to-deploy** | ≤ 1 día (Semana 4 del cronograma) | Tooling complejo (Kubernetes, multi-region) descartado. |
| **Cumplimiento legal** | Ley 1581 (Habeas Data Colombia) | Transferencia internacional permitida con aviso de privacidad explícito. |
| **Geografía usuarios** | Valle del Cauca, Colombia | Latencia aceptable: ≤ 150ms. Sync no es en tiempo real (offline-first). |

### 1.2 Filosofía

> **"Hacer lo mínimo que funcione hoy; añadir herramientas solo cuando el dolor las justifique."**

Cada herramienta del stack debe responder a una pregunta concreta: ¿qué se rompe sin ella en el contexto del piloto? Si la respuesta es "nada", se difiere.

---

## 2. Decisión de Proveedor: Oracle Cloud Free Tier

### 2.1 Resumen

| Elemento | Valor |
|----------|-------|
| **Proveedor** | Oracle Cloud Infrastructure (OCI) |
| **Región** | South America East (São Paulo, `sa-saopaulo-1`) |
| **Instancia** | VM.Standard.A1.Flex (ARM Ampere) |
| **Recursos** | 4 OCPU + 24 GB RAM + 200 GB block storage |
| **Costo** | $0/mes (always-free tier) |
| **OS** | Ubuntu 24.04 LTS (ARM64) |

### 2.2 Justificación

Oracle Cloud ofrece el tier gratuito más generoso del mercado: **always-free**, sin expiración (a diferencia del free tier de 12 meses de AWS). Una sola VM A1 cubre con holgura las necesidades del MVP (Postgres + Redis + API Node.js + reverse proxy + monitoring básico, todo en docker-compose).

### 2.3 Alternativas evaluadas

| Alternativa | Costo/mes | Región | Veredicto |
|-------------|-----------|--------|-----------|
| **Oracle Cloud Free Tier (São Paulo)** ⭐ | $0 | Brasil (~80ms a Cali) | **Elegido**: free perpetuo, recursos generosos, latencia aceptable |
| Hetzner Cloud CX11 | €3.79 (~$4.20) | Alemania (~150ms) | Descartado: no es gratis, latencia mayor |
| Fly.io (Bogotá BOG) | ~$5-10 | Colombia (~10ms) | Descartado para MVP: rompe restricción $0. Re-evaluar tras validación si Ley 1581 lo exige. |
| AWS EC2 t2.micro Free | $0 (12 meses) | N. Virginia | Descartado: expira en 12 meses, no Colombia |
| Self-host (laptop + Cloudflare Tunnel) | $0 | Cali (físico) | Descartado: SPOF en hardware doméstico, no escalable, riesgo cortes eléctricos |
| OpenStack autoadministrado | Variable | Variable | Descartado: requiere multi-nodo + ops dedicado, overkill total para 5 usuarios |

### 2.4 Riesgo conocido y mitigación

Oracle Cloud tiene reputación de **bloquear cuentas free** sin previo aviso (reportes frecuentes en HackerNews, Reddit). Mitigación:

- Backups diarios (`pg_dump`) descargados a almacenamiento local + Oracle Object Storage
- IaC mínimo (scripts bash versionados en `agritrace-infrastructure`) permite re-deploy en proveedor alternativo (Hetzner, Fly.io) en horas
- Sin lock-in propietario (Docker estándar, sin servicios OCI específicos)

---

## 3. Stack Mínimo: 8 Piezas con Propósito

Toda herramienta listada responde a una necesidad concreta del piloto. Ninguna es "por si acaso".

### 3.1 Compute — Oracle VM

**Propósito**: host físico (virtual) donde corre todo el sistema.
**Costo**: $0 always-free.
**Configuración**: 1 VM ARM64, Ubuntu 24.04 LTS, IP pública estática.

### 3.2 Runtime — Docker + Docker Compose

**Propósito**: aislar y orquestar servicios (Postgres, Redis, API Node, Caddy) en un solo host.
**Costo**: $0 (FOSS).
**Justificación**: reproducible, declarativo, sin instalar dependencias en el host. Cambios se gestionan editando `docker-compose.yml` y ejecutando `docker-compose up -d`.

### 3.3 Reverse Proxy + SSL — Caddy

**Propósito**: terminar HTTPS público en `api.agritrace.co`, redirigir al backend Node en `localhost:3000`, gestionar certificados Let's Encrypt automáticamente.
**Costo**: $0 (FOSS).
**Justificación**:
- Configuración mínima (Caddyfile de ~5 líneas vs ~30 líneas de Nginx)
- Auto-renovación de certificados sin `cron` ni `certbot`
- HTTP/2 y HTTP/3 nativos
- Bloquea exposición directa de servicios internos a internet

**Caddyfile referencial**:
```
api.agritrace.co {
    reverse_proxy localhost:3000
}
```

### 3.4 DNS y Protección Edge — Cloudflare (Free)

**Propósito**: resolver `agritrace.co` → IP de la VM; ocultar IP real tras proxy Cloudflare; protección DDoS y WAF básico.
**Costo**: $0 (Cloudflare Free Plan).
**Justificación**:
- DNS gestionado de baja latencia global
- Modo "proxied" (nube naranja) oculta IP de la VM Oracle, reduciendo superficie de ataque y scanning
- Permite repuntar a nuevo IP en segundos si Oracle suspende la cuenta
- WAF básico bloquea bots conocidos y patrones SQLi sin configuración adicional
- Sin Cloudflare, la IP del VM queda expuesta a scanners 24/7

### 3.5 Firewall del Host — ufw (Uncomplicated Firewall)

**Propósito**: cerrar todos los puertos del VM excepto los estrictamente necesarios.
**Costo**: $0 (preinstalado en Ubuntu).
**Configuración**:

```
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp     # SSH (acceso administrativo)
ufw allow 80/tcp     # HTTP (redirige a 443)
ufw allow 443/tcp    # HTTPS público
ufw enable
```

**Resultado**: Postgres (`5432`), Redis (`6379`) y Node (`3000`) quedan accesibles únicamente desde `localhost` dentro del VM, donde Caddy actúa como única puerta de entrada.

### 3.6 Prevención de Intrusión SSH — fail2ban

**Propósito**: banear automáticamente IPs que intenten autenticarse contra SSH con credenciales incorrectas reiteradamente.
**Costo**: $0 (FOSS).
**Configuración**: 5 intentos fallidos en 10 minutos → bloqueo de IP por 1 hora vía iptables.
**Justificación**: el puerto 22 expuesto a internet recibe intentos de fuerza bruta constantes. fail2ban reduce drásticamente el ruido en logs y el riesgo de compromiso por credenciales débiles.

### 3.7 Backups — pg_dump + Oracle Object Storage

**Propósito**: respaldo diario de la base de datos PostgreSQL, retenido durante 7 días, almacenado fuera del VM.
**Costo**: $0 (Oracle Object Storage incluye 20 GB free always).
**Mecánica**:

- Cron diario a las 03:00 UTC
- `pg_dump | gzip` → archivo con timestamp
- Subida al bucket `agritrace-backups` en Oracle Object Storage
- Rotación local: mantiene los últimos 7 días
- Script de restore documentado y probado antes del go-live

### 3.8 Monitoring de Uptime — UptimeRobot Externo (Free)

**Propósito**: verificar cada 5 minutos que `https://api.agritrace.co/health` responda `200 OK` y enviar email si falla.
**Costo**: $0 (UptimeRobot Free Plan, 50 monitores).
**Justificación**: monitoreo externo (no autohospedado) garantiza que detectará caídas incluso si la VM completa muere. Sin esto, una caída de servicio podría pasar desapercibida durante días.

---

## 4. Stack Diferido (Defer Roadmap)

Las siguientes herramientas se mencionaron en planificaciones previas pero **se difieren explícitamente** hasta que su trigger se materialice. Diferir ≠ descartar.

| Herramienta | Trigger para activar |
|-------------|----------------------|
| **Terraform** | Migración de proveedor, o necesidad de segundo entorno (staging) |
| **GitHub Actions CI/CD** | Más de un deploy por semana, o llegada de segundo contributor |
| **Sentry** | Más de 5 reportes de error por semana detectados en logs manuales |
| **Uptime Kuma (autohospedado)** | Necesidad de dashboard interno o más de 10 monitores |
| **sops + age (gestión de secretos cifrados)** | Repositorio público, o más de un desarrollador |
| **Ansible** | Más de 3 hosts a aprovisionar |
| **Kubernetes / k3s** | > 1000 usuarios activos o necesidad de zero-downtime deploy |
| **Postgres administrado (Neon, Supabase, Crunchy)** | > 100 usuarios activos o crecimiento de DB > 5 GB |
| **CDN Cloudflare cache rules avanzadas** | Tráfico estático medible (>10k req/día) |
| **Prometheus + Grafana** | Necesidad de métricas custom (no solo uptime) |
| **Logs centralizados (Loki / ELK)** | Más de un host o > 1 GB logs/día |
| **OpenStack autoadministrado** | Auditoría legal estricta exige infra 100% nacional + control hardware |

**Hosting en Colombia (Fly.io Bogotá / IFX / CAPACOL)**: se evaluará tras el cierre del Mes 1 del piloto, en función de si aparece demanda real de compliance Ley 1581 estricto.

---

## 5. Despliegue: 3 Fases en 1 Día

### Fase 1 — Bootstrap del Proveedor (1-2h)

1. Crear cuenta Oracle Cloud Free Tier
2. Lanzar VM Ampere A1 en `sa-saopaulo-1` (4 OCPU, 24 GB RAM, 200 GB block)
3. Asignar IP pública reservada (no efímera)
4. Comprar dominio (`agritrace.co` vía Cloudflare Registrar)
5. Configurar zona DNS en Cloudflare, apuntar NS desde el registrador
6. Crear registro `A` `api.agritrace.co` → IP del VM (modo proxied)

### Fase 2 — Hardening y Runtime (2-3h)

1. SSH con clave (sin password); deshabilitar root login y password auth en `/etc/ssh/sshd_config`
2. Instalar y configurar `ufw` y `fail2ban`
3. Configurar swap de 4 GB (la VM ARM Ampere no lo trae por defecto)
4. Instalar Docker Engine + Docker Compose plugin
5. Crear usuario no-root `agritrace` con permisos docker
6. Clonar `agritrace-backend` y `agritrace-infrastructure` en `/opt/agritrace`

### Fase 3 — Servicios y Backup (2-3h)

1. Crear `.env` con secretos (no commiteado; backup en gestor de contraseñas personal)
2. Levantar stack: `docker-compose up -d` (postgres, redis, agritrace-api, caddy)
3. Verificar SSL emitido y `https://api.agritrace.co/health` responde
4. Instalar cron job de `pg_dump` → Oracle Object Storage
5. Probar restore en VM temporal
6. Configurar monitor en UptimeRobot

---

## 6. Costos

| Concepto | Periodicidad | Monto USD | Monto COP aprox. |
|----------|--------------|-----------|------------------|
| VM Oracle Cloud (4 OCPU, 24 GB RAM) | Mensual | $0 | $0 |
| Oracle Object Storage 20 GB | Mensual | $0 | $0 |
| Cloudflare DNS + Proxy + WAF básico | Mensual | $0 | $0 |
| UptimeRobot Free (50 monitores) | Mensual | $0 | $0 |
| Dominio `agritrace.co` | Anual | ~$12 | ~$48.000 |
| **Total mensual** | — | **$0** | **$0** |
| **Total anual** | — | **~$12** | **~$48.000** |

---

## 7. Compliance: Ley 1581 (Habeas Data)

### 7.1 Situación

Los datos personales de agricultores (nombre, ubicación de finca, teléfono) se almacenarán en Oracle Cloud São Paulo (Brasil), no en Colombia. La Ley 1581 permite transferencia internacional bajo las siguientes condiciones:

- El titular **otorga consentimiento explícito** para la transferencia
- El país destino otorga **nivel adecuado de protección** (Brasil cumple desde la LGPD 2018)
- Existe **aviso de privacidad accesible** que describe la transferencia

### 7.2 Acciones requeridas antes del go-live

- [ ] Redactar política de privacidad explícita en español, incluyendo:
  - Datos recolectados
  - Finalidad
  - Transferencia internacional a Brasil (Oracle Cloud)
  - Derechos ARCO del titular
  - Contacto para ejercer derechos
- [ ] Implementar pantalla de consentimiento al registro
- [ ] Registrar tratamiento de datos en SIC (Superintendencia de Industria y Comercio) cuando la base supere 10.000 titulares (no aplica en piloto de 5)

### 7.3 Reevaluación

Si la validación comercial confirma tracción y la base supera 100 agricultores, evaluar migración a hosting nacional (Fly.io Bogotá o proveedor local como IFX/CAPACOL) en iteración futura.

---

## 8. Riesgos y Mitigaciones

| Riesgo | Probabilidad | Impacto | Mitigación |
|--------|--------------|---------|------------|
| Oracle suspende cuenta free sin previo aviso | Media | Alto | Backups diarios externos + IaC reproducible permite re-deploy en otro proveedor en horas |
| Caída de la VM (single point of failure) | Baja | Medio | Aceptable en piloto. Restore documentado y probado. RTO objetivo: 2 horas. |
| Pérdida de datos en período sin backup (RPO 24h) | Baja | Medio | Aceptable en piloto (sync ocurre diariamente, no es tiempo real) |
| Compromiso de credenciales SSH | Baja | Alto | Auth solo por clave, fail2ban, ufw, sin root login |
| Exposición accidental de puerto interno | Media | Alto | ufw cierra por defecto; Docker binds explícitos a `127.0.0.1` |
| Auditoría Ley 1581 detecta no conformidades | Baja | Medio | Aviso de privacidad explícito + consentimiento documentado |
| ARM64 incompatible con alguna dependencia | Baja | Bajo | Node.js, PostgreSQL, Redis, Caddy soportan ARM64 oficialmente |

---

## 9. Definición de "Done" (Infraestructura MVP)

- [ ] VM Oracle Cloud aprovisionada con IP pública estática
- [ ] Dominio `agritrace.co` registrado y delegado a Cloudflare
- [ ] DNS `api.agritrace.co` resolviendo correctamente, modo proxied activado
- [ ] SSH endurecido (sin password auth, sin root login)
- [ ] `ufw` activo con política `deny incoming` por defecto
- [ ] `fail2ban` corriendo y baneando intentos fallidos
- [ ] Docker + Docker Compose instalados
- [ ] Stack `docker-compose` corriendo: postgres, redis, agritrace-api, caddy
- [ ] HTTPS funcionando con certificado Let's Encrypt válido en `api.agritrace.co`
- [ ] Endpoint `GET /health` responde `200 OK`
- [ ] Backup `pg_dump` ejecutándose diariamente a las 03:00 UTC
- [ ] Restore de backup probado en VM temporal y documentado
- [ ] UptimeRobot monitoreando `/health` cada 5 min con alerta a email
- [ ] Política de privacidad publicada y enlazada desde la app
- [ ] Repositorio `agritrace-infrastructure` con scripts versionados y README

---

## 10. Documentos Relacionados (a crear)

Los siguientes documentos completan esta sección y se desarrollarán en orden:

1. **`02-topologia.md`** — Diagrama de topología: VM, contenedores, red, Cloudflare, flujo de tráfico
2. **`03-secretos-y-backups.md`** — Detalle de gestión de `.env`, rotación de claves, política de backups
3. **`04-costos-y-escalado.md`** — Modelado de costos proyectado por rangos de usuarios; triggers de migración

El repositorio `agritrace-infrastructure` contendrá la implementación concreta (scripts, Caddyfile, docker-compose.yml de producción).

---

## 11. Referencias

- Alcance MVP: [`../09-scope-mvp.md`](../09-scope-mvp.md)
- Arquitectura técnica: [`../05-arquitectura-tecnica/01-resumen-arquitectura.md`](../05-arquitectura-tecnica/01-resumen-arquitectura.md)
- Configuración Docker local: [`../../02-documentacion-tecnica/docker-compose-dev.md`](../../02-documentacion-tecnica/docker-compose-dev.md)
- Cronograma comercial: [`../10-comercial-gtm/09-cronograma-validacion-4-semanas.md`](../10-comercial-gtm/09-cronograma-validacion-4-semanas.md)
- Ley 1581 de 2012 (Habeas Data Colombia) y Decreto 1377 de 2013
