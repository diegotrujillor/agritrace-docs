# Configuración de Desarrollo Local (Docker Compose)

Guía para configurar el entorno de desarrollo local usando Docker Compose.

## Prerequisitos

- Docker Desktop (o Docker Engine + Docker Compose)
- Git
- Node.js 18+ (para ejecutar el API fuera de contenedor, opcional)

## Inicio Rápido

### 1. Clonar Repositorios

```bash
git clone https://github.com/diegotrujillor/agritrace-docs.git
git clone https://github.com/diegotrujillor/agritrace-backend.git
git clone https://github.com/diegotrujillor/agritrace-prototype.git
```

### 2. Crear archivo `docker-compose.yml`

Crea `docker-compose.yml` en la raíz del proyecto backend:

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:15-alpine
    container_name: agritrace-postgres
    environment:
      POSTGRES_DB: agritrace_mvp
      POSTGRES_USER: agritrace_user
      POSTGRES_PASSWORD: dev_password_123
      POSTGRES_INITDB_ARGS: "-c timezone=UTC"
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./scripts/init-db.sql:/docker-entrypoint-initdb.d/01-init.sql
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U agritrace_user -d agritrace_mvp"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    container_name: agritrace-redis
    ports:
      - "6379:6379"
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  postgres_data:
```

### 3. Inicializar Base de Datos

Copia el esquema SQL desde `/02-documentacion-tecnica/02-base-de-datos/01-diseno-base-datos.md`:

```bash
mkdir -p scripts
# Copia el SQL DDL completo a scripts/init-db.sql
```

### 4. Iniciar Servicios

```bash
# Desde el directorio del backend
docker-compose up -d

# Verificar estado
docker-compose ps

# Ver logs
docker-compose logs -f postgres
docker-compose logs -f redis
```

### 5. Verificar Conectividad

```bash
# Test PostgreSQL
psql -h localhost -U agritrace_user -d agritrace_mvp -c "SELECT version();"

# Test Redis
redis-cli ping
```

## Variables de Entorno

Crea `.env` en el backend:

```env
DATABASE_URL=postgresql://agritrace_user:dev_password_123@localhost:5432/agritrace_mvp
REDIS_URL=redis://localhost:6379
NODE_ENV=development
JWT_SECRET=dev_secret_key_change_in_production
API_PORT=3000
```

## Detener Servicios

```bash
docker-compose down

# Con limpieza de volúmenes (borrar datos)
docker-compose down -v
```

## Troubleshooting

**Error: "port 5432 already in use"**
```bash
docker-compose down -v
# O cambiar puerto en docker-compose.yml
```

**Error: "Cannot connect to PostgreSQL"**
```bash
# Esperar a que el contenedor esté listo
docker-compose logs postgres
# Esperar a "database system is ready to accept connections"
```

**Base de datos vacía después de iniciar**
```bash
# Verificar que init-db.sql existe en scripts/
docker-compose down -v
docker-compose up -d
```

## Para Desarrollo

### Backend Node.js

```bash
# Instalar dependencias
npm install

# Ejecutar migraciones
npm run migrate

# Iniciar servidor
npm run dev
# API escuchará en http://localhost:3000
```

### Frontend Flutter

```bash
# Configurar ambiente mock (mientras backend está en desarrollo)
cd agritrace-prototype
flutter pub get
flutter run
```

## Referencias

- Esquema de base de datos: `/02-documentacion-tecnica/02-base-de-datos/01-diseno-base-datos.md`
- Especificación de API: `/02-documentacion-tecnica/03-api/01-especificacion-openapi.yaml`
- Directrices de desarrollo: `/02-documentacion-tecnica/04-desarrollo/01-directrices-desarrollo.md`
