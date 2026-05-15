# 03 - Gestión de Secretos y Backups

**Fecha**: Mayo 2026
**Versión**: 1.0
**Estado**: Aprobado para implementación
**Responsable**: Diego Trujillo
**Documento padre**: [01-decisiones-infra.md](01-decisiones-infra.md)

---

## 1. Resumen

Este documento define el manejo operativo de **dos preocupaciones críticas** del piloto:

1. **Secretos**: credenciales, claves y tokens que la aplicación necesita en runtime.
2. **Backups**: respaldo de datos persistentes para garantizar recuperación ante fallos.

Ambos temas se tratan con herramientas mínimas (sin Vault, sin sops, sin KMS externo) acordes con la escala del piloto. Cuando los triggers de escalado se materialicen, los reemplazos están documentados en [01-decisiones-infra.md §4](01-decisiones-infra.md).

---

## Parte A: Gestión de Secretos

## 2. Inventario de Secretos

Los siguientes secretos viven en el archivo `.env` del backend en producción:

| Variable | Propósito | Formato | Rotación |
|----------|-----------|---------|----------|
| `DATABASE_URL` | Conexión Postgres | `postgresql://user:pass@host:5432/db` | Cuando se rote password Postgres |
| `POSTGRES_PASSWORD` | Password del usuario aplicación | 24+ chars aleatorios | Anual o al rotar usuarios |
| `REDIS_URL` | Conexión Redis | `redis://:pass@host:6379` | Anual |
| `REDIS_PASSWORD` | Password Redis | 24+ chars aleatorios | Anual |
| `JWT_ACCESS_SECRET` | Firma JWT access token | 64 hex chars | Cada 90 días |
| `JWT_REFRESH_SECRET` | Firma JWT refresh token | 64 hex chars | Cada 90 días |
| `ENCRYPTION_KEY` | Cifrado de campos sensibles a nivel app | 32 bytes base64 | Anual con plan de migración |
| `SENTRY_DSN` | Reporte de errores (cuando se active) | URL | N/A (rotación gestionada por Sentry) |
| `OCI_BACKUP_KEY_FILE_PATH` | Path a API key OCI para subir backups | Path local | Anual |
| `ADMIN_BOOTSTRAP_PASSWORD` | Password del primer usuario admin | 16+ chars | Inmediato post-primer-login |

Adicionalmente fuera de `.env`:

| Recurso | Almacenamiento | Acceso |
|---------|----------------|--------|
| Llave SSH privada del desarrollador | `~/.ssh/id_ed25519_personal` en laptop | Solo Diego |
| Llave API OCI privada (`.pem`) | `~/.oci/oci_api_key.pem` en laptop y VM (solo para backups) | Solo Diego + cron de la VM |
| Credenciales de cuentas (Oracle, Cloudflare, UptimeRobot, dominio) | Password manager personal | Solo Diego |

---

## 3. Generación de Secretos

Todos los secretos del piloto se generan con utilitarios estándar de la shell. Sin gestores externos.

### Comandos

```bash
# Password Postgres / Redis (24 chars URL-safe, sin caracteres problemáticos en URIs)
openssl rand -base64 24 | tr -d "=+/" | cut -c1-24

# JWT secrets (64 hex chars = 256 bits entropía)
openssl rand -hex 32

# Encryption key (32 bytes base64 para AES-256)
openssl rand -base64 32

# Password admin temporal (16 chars alfanuméricos)
openssl rand -base64 12 | tr -d "=+/" | cut -c1-16
```

### Reglas

- Nunca reutilizar secretos entre servicios (DB ≠ Redis ≠ JWT ≠ encryption)
- Nunca commitear secretos al repositorio (`.gitignore` incluye `.env`, `*.pem`, `secrets/`)
- Nunca enviar secretos por canales no cifrados (email plano, Slack público, screenshots)

---

## 4. Almacenamiento

### 4.1 En producción (VM Oracle)

- Archivo: `/opt/agritrace/.env`
- Owner: `agritrace:agritrace`
- Permisos: `600` (solo owner lee/escribe)
- Docker Compose lo lee vía directiva `env_file:` (no se monta como volumen)
- Logs de la aplicación nunca imprimen variables del entorno completas

### 4.2 En desarrollo (laptop Diego)

- Archivo: `.env.local` en cada repo (en `.gitignore`)
- Valores **distintos** a producción (passwords débiles aceptables en local)

### 4.3 Backup canónico (Master Copy)

- Almacén: **password manager personal** (1Password / Bitwarden, a confirmar por Diego)
- Estructura: una entrada por secreto, con metadata (fecha generación, próxima rotación)
- Acceso: solo Diego
- Master password del gestor: respaldada en lugar físico separado (sobre cerrado o caja fuerte)

### 4.4 Plantilla compartible

- Archivo: `agritrace-infrastructure/compose/.env.example`
- Contiene **nombres de variables sin valores**, comentarios explicativos
- Sí se commitea al repo (privado u público)

Ejemplo de `.env.example`:

```bash
# Database
DATABASE_URL=postgresql://agritrace:CHANGEME@postgres:5432/agritrace_mvp
POSTGRES_PASSWORD=CHANGEME

# Redis
REDIS_URL=redis://:CHANGEME@redis:6379
REDIS_PASSWORD=CHANGEME

# JWT (generar con: openssl rand -hex 32)
JWT_ACCESS_SECRET=CHANGEME_64_HEX_CHARS
JWT_REFRESH_SECRET=CHANGEME_64_HEX_CHARS

# Encryption (generar con: openssl rand -base64 32)
ENCRYPTION_KEY=CHANGEME_44_BASE64_CHARS

# Bootstrap admin
ADMIN_BOOTSTRAP_EMAIL=admin@agritrace.co
ADMIN_BOOTSTRAP_PASSWORD=CHANGEME

# Sentry (opcional, diferido)
SENTRY_DSN=

# Node
NODE_ENV=production
API_PORT=3000
```

---

## 5. Rotación de Secretos

### 5.1 Calendario

| Secreto | Periodicidad | Trigger adicional |
|---------|--------------|-------------------|
| `JWT_ACCESS_SECRET` y `JWT_REFRESH_SECRET` | 90 días | Sospecha de compromiso → inmediato |
| `POSTGRES_PASSWORD`, `REDIS_PASSWORD` | Anual | Cambio de personal con acceso |
| `ENCRYPTION_KEY` | Anual | Solo con plan de migración de datos cifrados |
| `ADMIN_BOOTSTRAP_PASSWORD` | Una sola vez | Tras primer login del admin |
| SSH key personal | Anual | Pérdida/robo de dispositivo |
| API key OCI | Anual | Diego sale del proyecto / cambio de cuenta Oracle |

### 5.2 Procedimiento de rotación JWT

```bash
# 1. Generar nuevos secretos
NEW_ACCESS=$(openssl rand -hex 32)
NEW_REFRESH=$(openssl rand -hex 32)

# 2. Editar /opt/agritrace/.env en la VM
ssh agritrace@api.agritrace.co
sudo nano /opt/agritrace/.env
# (actualizar JWT_ACCESS_SECRET y JWT_REFRESH_SECRET)

# 3. Restart del backend
docker compose -f /opt/agritrace/compose/docker-compose.prod.yml restart agritrace-api

# 4. Actualizar copia en password manager

# 5. Efecto colateral conocido: todos los tokens emitidos previamente quedan invalidados
#    → usuarios deben re-loguear
#    → comunicar vía in-app notice si hay > 5 usuarios activos
```

### 5.3 Procedimiento de rotación Postgres password

```bash
# 1. Generar nuevo password
NEW_PG_PASS=$(openssl rand -base64 24 | tr -d "=+/" | cut -c1-24)

# 2. Cambiar password dentro de Postgres
docker compose exec postgres psql -U postgres -c \
  "ALTER USER agritrace WITH PASSWORD '$NEW_PG_PASS';"

# 3. Actualizar .env (DATABASE_URL y POSTGRES_PASSWORD)
sudo nano /opt/agritrace/.env

# 4. Recrear el contenedor del backend (Postgres queda intacto)
docker compose up -d agritrace-api

# 5. Actualizar password manager
```

### 5.4 Recuperación si los secretos se pierden

| Secreto perdido | Consecuencia | Recuperación |
|-----------------|--------------|--------------|
| `JWT_ACCESS_SECRET` y `JWT_REFRESH_SECRET` | Tokens emitidos quedan inválidos | Regenerar + restart + usuarios re-loguean |
| `POSTGRES_PASSWORD` | Backend no conecta a DB | Rotar password DB (paso 5.3) + restart |
| `ENCRYPTION_KEY` | **CRÍTICO**: datos cifrados con esa key son irrecuperables | Restore de backup pre-pérdida + migrar dataset |
| `ADMIN_BOOTSTRAP_PASSWORD` (antes de primer login) | Sin acceso admin | Cambiar en `.env` + restart antes del primer login |
| SSH key personal | Sin acceso administrativo a VM | Acceso vía Oracle Console (VNC/serial) → reinyectar clave nueva por cloud-init metadata |
| API key OCI | Sin acceso a Object Storage (backups) | Generar nueva en consola → actualizar `~/.oci/config` en VM y laptop |

---

## 6. Reglas de Higiene

- ❌ **No imprimir** secretos en logs (filtrar en middleware de logging)
- ❌ **No exponer** errores que incluyan stack traces con variables del entorno
- ❌ **No hardcodear** valores de prueba en código que coincidan con producción
- ❌ **No enviar** `.env` por email/chat/screenshot
- ✅ **Sí auditar** acceso a la VM con `last` y `journalctl _COMM=sshd`
- ✅ **Sí revisar** `.env` en producción tras cada deploy (verificar que no se commiteó por error)
- ✅ **Sí incluir** `.env`, `*.pem`, `secrets/`, `.envrc` en `.gitignore` global del proyecto

---

## Parte B: Backups

## 7. Inventario de Datos a Respaldar

| Dato | Importancia | Mecánica | Frecuencia |
|------|-------------|----------|------------|
| **PostgreSQL (`agritrace_mvp` database)** | Crítica | `pg_dump -Fc` | Diaria |
| **Uploads de fotos de actividades** (si se almacenan en disco local) | Alta | `tar + gzip` del directorio | Diaria |
| **Configuración: `.env`, `Caddyfile`, `docker-compose.yml`** | Media | Versionado en git (`agritrace-infrastructure`) + copia en password manager | Continua |
| **Logs de aplicación** | Baja | `logrotate` local, retenidos 14 días | Continua |
| **Redis (cache)** | Ninguna | No se respalda (datos efímeros reconstruibles) | N/A |

---

## 8. Backup de PostgreSQL

### 8.1 Especificación

- **Herramienta**: `pg_dump -Fc` (formato `custom`: binario, comprimido, restaurable con `pg_restore`)
- **Frecuencia**: cron diario a las **03:00 UTC** (= 22:00 hora Cali del día anterior)
- **Destino primario**: bucket Oracle Object Storage `agritrace-backups`
- **Destino secundario**: directorio local `/var/backups/agritrace/` (últimos 3 días)
- **Retención remota**: 7 días (vía lifecycle policy del bucket)
- **Tamaño esperado piloto**: < 50 MB comprimido
- **RPO (Recovery Point Objective)**: 24 horas
- **RTO (Recovery Time Objective)**: ≤ 2 horas

### 8.2 Script `backup-pg.sh`

Ubicación: `agritrace-infrastructure/backup/backup-pg.sh`

```bash
#!/usr/bin/env bash
#
# Backup diario de PostgreSQL para AgriTrace.
# Ejecutado por cron a las 03:00 UTC.
#

set -euo pipefail

# ---------- Configuración ----------

BACKUP_DIR="/var/backups/agritrace"
RETENTION_LOCAL_DAYS=3
BUCKET="agritrace-backups"
NAMESPACE="$(oci os ns get --query 'data' --raw-output)"
LOG_FILE="/var/log/agritrace/backup.log"

DB_CONTAINER="agritrace-postgres"
DB_NAME="agritrace_mvp"
DB_USER="agritrace"

# ---------- Setup ----------

mkdir -p "$BACKUP_DIR" "$(dirname "$LOG_FILE")"
TIMESTAMP="$(date -u '+%Y%m%dT%H%M%SZ')"
DUMP_FILE="$BACKUP_DIR/agritrace-${TIMESTAMP}.dump.gz"

log() {
    echo "[$(date -u '+%Y-%m-%dT%H:%M:%SZ')] $*" | tee -a "$LOG_FILE"
}

# ---------- Backup ----------

log "Backup iniciado: $DUMP_FILE"

docker exec "$DB_CONTAINER" \
    pg_dump -Fc -U "$DB_USER" -d "$DB_NAME" \
    | gzip -9 > "$DUMP_FILE"

DUMP_SIZE=$(stat -f%z "$DUMP_FILE" 2>/dev/null || stat -c%s "$DUMP_FILE")
log "Dump completado: ${DUMP_SIZE} bytes"

# Calcular checksum
SHA="$(shasum -a 256 "$DUMP_FILE" | awk '{print $1}')"
log "SHA-256: $SHA"

# Subir a Object Storage
OBJECT_NAME="$(basename "$DUMP_FILE")"
oci os object put \
    --bucket-name "$BUCKET" \
    --namespace "$NAMESPACE" \
    --file "$DUMP_FILE" \
    --name "$OBJECT_NAME" \
    --content-md5 "$(openssl dgst -md5 -binary "$DUMP_FILE" | base64)" \
    --force >> "$LOG_FILE" 2>&1

log "Subido a Object Storage: $OBJECT_NAME"

# Verificar (head del objeto)
oci os object head \
    --bucket-name "$BUCKET" \
    --namespace "$NAMESPACE" \
    --name "$OBJECT_NAME" \
    --query 'etag' --raw-output >> "$LOG_FILE" 2>&1

# Rotar locales
find "$BACKUP_DIR" -name "agritrace-*.dump.gz" -mtime +${RETENTION_LOCAL_DAYS} -delete
log "Rotación local: backups > ${RETENTION_LOCAL_DAYS} días eliminados"

log "Backup OK ✅"
exit 0
```

### 8.3 Cron entry

```cron
# /etc/cron.d/agritrace-backup
# Ejecuta como user agritrace, no root
0 3 * * * agritrace /opt/agritrace/scripts/backup-pg.sh >> /var/log/agritrace/backup-cron.log 2>&1
```

### 8.4 Lifecycle policy del bucket

Configurada vía OCI Console (Object Storage → bucket → Lifecycle Rules):

```json
{
  "name": "delete-after-7-days",
  "action": "DELETE",
  "objectNameFilter": {
    "inclusionPatterns": ["agritrace-*.dump.gz"]
  },
  "timeAmount": 7,
  "timeUnit": "DAYS"
}
```

---

## 9. Backup de Uploads

Si la aplicación guarda fotos de actividades en disco local del VM (volumen Docker), respaldarlas:

```bash
# Diariamente, anexar al cron
tar -czf "/var/backups/agritrace/uploads-${TIMESTAMP}.tar.gz" \
    /opt/agritrace/uploads \
    --exclude='*.tmp'
oci os object put --bucket-name "$BUCKET" --file ...
```

**Nota MVP**: si las fotos van directo a Object Storage (no a disco del VM), este paso no aplica. Decisión queda al diseño del API (ver `agritrace-backend`).

---

## 10. Procedimiento de Restore

### 10.1 Casos de uso

- Corrupción de DB
- Borrado accidental de datos
- Migración a nueva VM (post-suspensión de cuenta Oracle)
- Drill mensual de validación

### 10.2 Script `restore-pg.sh`

Ubicación: `agritrace-infrastructure/backup/restore-pg.sh`

```bash
#!/usr/bin/env bash
#
# Restore de PostgreSQL desde Object Storage.
# Usage: ./restore-pg.sh <object-name>
#

set -euo pipefail

OBJECT_NAME="${1:?Uso: $0 <object-name>}"
BUCKET="agritrace-backups"
NAMESPACE="$(oci os ns get --query 'data' --raw-output)"
DB_CONTAINER="agritrace-postgres"
DB_NAME="agritrace_mvp"
DB_USER="agritrace"

WORK_DIR="$(mktemp -d)"
DUMP_FILE="$WORK_DIR/$(basename "$OBJECT_NAME")"

echo "Descargando: $OBJECT_NAME"
oci os object get \
    --bucket-name "$BUCKET" \
    --namespace "$NAMESPACE" \
    --name "$OBJECT_NAME" \
    --file "$DUMP_FILE"

echo "Descomprimiendo y restaurando a DB '$DB_NAME'..."
gunzip "$DUMP_FILE"
DUMP_BIN="${DUMP_FILE%.gz}"

# Restaurar (drop + recreate)
docker exec -i "$DB_CONTAINER" psql -U postgres -c "DROP DATABASE IF EXISTS $DB_NAME;"
docker exec -i "$DB_CONTAINER" psql -U postgres -c "CREATE DATABASE $DB_NAME OWNER $DB_USER;"
docker exec -i "$DB_CONTAINER" pg_restore -U "$DB_USER" -d "$DB_NAME" < "$DUMP_BIN"

echo "Restore completado ✅"
rm -rf "$WORK_DIR"
```

### 10.3 Verificación post-restore

```bash
# Conteo de registros clave
docker exec agritrace-postgres psql -U agritrace -d agritrace_mvp -c \
    "SELECT 'users' AS tabla, COUNT(*) FROM users
     UNION ALL SELECT 'farms', COUNT(*) FROM farms
     UNION ALL SELECT 'activities', COUNT(*) FROM activities;"

# Endpoint health check
curl -fsSL https://api.agritrace.co/health
```

---

## 11. Drill Mensual de Restore

**Por qué**: backup no probado = no backup. Sin restore drill, no hay garantía de recuperación.

### Procedimiento

1. **Día 15 de cada mes**, lanzar VM scratch en Oracle Free Tier (E2.1.Micro) — duración 30-45 min
2. Instalar Docker + Postgres
3. Descargar último backup de Object Storage
4. Ejecutar `restore-pg.sh`
5. Validar:
   - Restore termina sin errores
   - Conteos de tablas razonables (no 0 filas en `users`)
   - Schema completo (todas las tablas críticas presentes)
6. Anotar en log de operaciones: fecha, duración, observaciones
7. Destruir VM scratch

### Métricas a registrar

| Métrica | Objetivo |
|---------|----------|
| Tiempo de descarga | < 60 s |
| Tiempo de restore | < 5 min |
| Tamaño backup | Trending — alerta si > 500 MB |
| % tablas recuperadas | 100% |

---

## 12. Alertas

### MVP (mínimo)

- El script `backup-pg.sh` retorna **exit code ≠ 0** → logueado en `/var/log/agritrace/backup.log` y `backup-cron.log`
- Revisión semanal manual de logs (lunes 9am Cali)

### Iteración futura (cuando crezca el piloto)

- Alerta email/Slack si:
  - El script falla 1+ veces
  - El backup local no se actualiza > 25h
  - El tamaño del backup cae > 50% (señal de DB vacía o corrupta)
  - El upload a Object Storage falla > 24h
- Herramienta: Healthchecks.io free tier (ping en cada ejecución exitosa, alerta si falta ping)

---

## 13. Cumplimiento de Ley 1581 sobre Backups

Los backups contienen datos personales de agricultores y heredan las obligaciones legales:

- **Localización de datos**: el bucket de backup vive en la misma región de la VM (Bogotá u origen). Si por capacidad la VM termina en otra región (ej. São Paulo), aplicar las cláusulas de transferencia internacional documentadas en [`01-decisiones-infra.md §7`](01-decisiones-infra.md).
- **Período de retención**: 7 días en el bucket + 3 días local = máximo 10 días de retención agregada.
- **Derecho al olvido (ARCO)**: si un agricultor solicita borrado de sus datos, se debe:
  1. Eliminar de la DB activa (`DELETE FROM users WHERE id = ?` + cascade)
  2. Marcar la solicitud en un log de eliminaciones
  3. Los backups serán "purgados naturalmente" al rotarse en 7 días (no es eficiente forzar la purga de backups históricos, pero el cumplimiento se garantiza por la corta retención).
- **Acceso**: solo Diego (vía API key OCI) puede descargar backups. Auditoría en Oracle Audit Service (logs de 365 días automáticos).

---

## 14. Riesgos y Mitigaciones

| Riesgo | Probabilidad | Impacto | Mitigación |
|--------|--------------|---------|------------|
| Backup falla silenciosamente por días | Media | Crítico | Revisión semanal manual + drill mensual + alerting en iteración futura |
| Bucket suspendido junto con la cuenta Oracle | Baja | Crítico | Copia adicional semanal a Cloudflare R2 (free 10 GB) — iteración futura si la tracción se confirma |
| `pg_dump` corrupto por DB inconsistente | Baja | Alto | Postgres en docker = aislado; checksum SHA-256 verifica integridad |
| Restore lento por DB grande | Media (futuro) | Medio | Particionado de tablas grandes en iteración futura |
| API key OCI comprometida → atacante borra backups | Baja | Crítico | Lifecycle policy es DELETE-only (sin permisos UPDATE/CREATE); la key se restringe a operaciones de object storage |
| Restore drill fallido detectado tarde | Media | Alto | Cadencia mensual fija (día 15) en calendario personal |

---

## 15. Definición de "Done"

- [ ] Inventario de secretos completo y documentado (sección 2)
- [ ] `.env.example` plantilla creada en `agritrace-infrastructure/compose/`
- [ ] Procedimientos de generación (`openssl rand`) probados y reproducibles
- [ ] Master copy de secretos en password manager personal con metadata
- [ ] `.gitignore` configurado en todos los repos (`.env`, `*.pem`, `secrets/`)
- [ ] Script `backup-pg.sh` desplegado en VM y ejecutable
- [ ] Cron entry instalada y verificada con primera ejecución
- [ ] Bucket `agritrace-backups` creado con lifecycle 7 días
- [ ] Script `restore-pg.sh` documentado y probado en VM scratch
- [ ] Restore drill #1 ejecutado exitosamente antes del go-live
- [ ] Calendario mensual con recordatorio de drill (día 15)
- [ ] Plan de rotación JWT calendarizado (próxima: 90 días post go-live)

---

## 16. Referencias

- Decisiones de infraestructura: [`01-decisiones-infra.md`](01-decisiones-infra.md)
- Topología (flujo de backup): [`02-topologia.md`](02-topologia.md) §6
- Modelado de costos: [`04-costos-y-escalado.md`](04-costos-y-escalado.md)
- Documentación pg_dump: https://www.postgresql.org/docs/15/app-pgdump.html
- OCI Object Storage CLI: https://docs.oracle.com/en-us/iaas/tools/oci-cli/latest/oci_cli_docs/cmdref/os/object.html
- Healthchecks.io (alerting futuro): https://healthchecks.io/
- Ley 1581 de 2012 y Decreto 1377 de 2013
