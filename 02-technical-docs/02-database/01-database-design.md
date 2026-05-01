# 🗄️ DATABASE DESIGN — AgriTrace MVP

**Versión:** 1.0  
**Fecha:** 30 de Abril de 2026  
**Base de Datos:** PostgreSQL 14+

---

## 📊 DIAGRAMA ENTIDAD-RELACIÓN (ERD)

```
┌─────────────────┐
│     USERS       │
├─────────────────┤
│ id (PK, UUID)   │
│ email (UNIQUE)  │
│ password (HASH) │
│ fullName        │
│ phone           │
│ role            │ ──┐
│ isActive        │   │
│ createdAt       │   │
│ updatedAt       │   │
└─────────────────┘   │
        │             │
        ├─────────────┼────────────┐
        │             │            │
        ▼             ▼            ▼
┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│  PRODUCERS   │ │COOPERATIVES  │ │  EXPORTERS   │
├──────────────┤ ├──────────────┤ ├──────────────┤
│ id (FK)      │ │ id (FK)      │ │ id (FK)      │
│ userId (FK)  │ │ userId (FK)  │ │ userId (FK)  │
│ organization │ │ name         │ │ company      │
│ registryNum  │ │ registryNum  │ │ registryNum  │
│ createdAt    │ │ createdAt    │ │ createdAt    │
└──────────────┘ └──────────────┘ └──────────────┘
        │
        │ 1..N
        │
        ▼
┌─────────────────┐
│      FARMS      │
├─────────────────┤
│ id (PK, UUID)   │
│ producerId (FK) │ ──┐
│ name            │   │
│ municipality    │   │
│ vereda          │   │
│ latitude        │   │
│ longitude       │   │
│ mainCrop        │   │
│ area (hectares) │   │
│ isActive        │   │
│ createdAt       │   │
│ updatedAt       │   │
└─────────────────┘   │
        │             │
        │ 1..N        │
        │             │
        ▼             │
┌─────────────────┐   │
│      PLOTS      │   │
├─────────────────┤   │
│ id (PK, UUID)   │   │
│ farmId (FK)     │───┘
│ name            │
│ crop            │
│ area (hectares) │
│ sowingDate      │
│ expectedHarvestDate
│ status          │
│ createdAt       │
└─────────────────┘
        │
        │ 1..N
        │
        ▼
┌──────────────────────┐     ┌──────────────────┐
│    ACTIVITIES        │     │   QR_CODES       │
├──────────────────────┤     ├──────────────────┤
│ id (PK, UUID)        │     │ id (PK, UUID)    │
│ plotId (FK)          │     │ plotId (FK)      │
│ type                 │     │ code (UNIQUE)    │
│ date                 │     │ url              │
│ notes                │     │ generatedAt      │
│ createdAt            │     └──────────────────┘
└──────────────────────┘
        │
        │ 1..N
        │
        ▼
┌──────────────────────┐
│  ACTIVITY_IMAGES     │
├──────────────────────┤
│ id (PK, UUID)        │
│ activityId (FK)      │
│ imageUrl             │
│ filename             │
│ size                 │
│ uploadedAt           │
└──────────────────────┘

┌──────────────────────┐
│   CERTIFICATES       │
├──────────────────────┤
│ id (PK, UUID)        │
│ plotId (FK)          │
│ type                 │
│ issueDate            │
│ expiryDate           │
│ documentUrl          │
│ status               │
│ verifiedBy (FK)      │ ──┐
│ verifiedAt           │   │
│ createdAt            │   │
└──────────────────────┘   │
                           │
                           ▼
                    ┌──────────────┐
                    │    ADMINS    │
                    ├──────────────┤
                    │ id (FK)      │
                    │ userId (FK)  │
                    │ permissions  │
                    └──────────────┘

┌──────────────────────┐
│   AUDIT_LOGS         │
├──────────────────────┤
│ id (PK, UUID)        │
│ userId (FK)          │
│ action               │
│ entityType           │
│ entityId             │
│ changes (JSON)       │
│ ipAddress            │
│ timestamp            │
└──────────────────────┘
```

---

## 📋 ESPECIFICACIÓN DETALLADA DE TABLAS

### **1. USERS**
**Descripción:** Tabla central de autenticación. Almacena credenciales y datos básicos de todos los usuarios.

```sql
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  full_name VARCHAR(255) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  role VARCHAR(50) NOT NULL CHECK (role IN ('producer', 'cooperative', 'exporter', 'buyer', 'admin')),
  is_active BOOLEAN DEFAULT true,
  email_verified BOOLEAN DEFAULT false,
  email_verified_at TIMESTAMP,
  last_login TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_is_active ON users(is_active);
```

**Notas:**
- `password_hash`: Debe ser hasheado con bcrypt (min 10 rondas)
- `role`: Define qué módulos ve el usuario
- `deleted_at`: Soft delete (no eliminar registro físicamente)

---

### **2. PRODUCERS**
**Descripción:** Perfil extendido de productores agrícolas.

```sql
CREATE TABLE producers (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
  organization VARCHAR(255),
  registry_number VARCHAR(100),
  region VARCHAR(100),
  certification_status VARCHAR(50) DEFAULT 'pending',
  is_verified BOOLEAN DEFAULT false,
  verified_at TIMESTAMP,
  verified_by UUID REFERENCES admins(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_producers_user_id ON producers(user_id);
CREATE INDEX idx_producers_is_verified ON producers(is_verified);
```

---

### **3. COOPERATIVES**
**Descripción:** Perfil de cooperativas que agrupan productores.

```sql
CREATE TABLE cooperatives (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  registry_number VARCHAR(100),
  representativeName VARCHAR(255),
  producersCount INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_cooperatives_user_id ON cooperatives(user_id);
```

---

### **4. EXPORTERS**
**Descripción:** Perfil de empresas exportadoras.

```sql
CREATE TABLE exporters (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
  company_name VARCHAR(255) NOT NULL,
  registry_number VARCHAR(100),
  country VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_exporters_user_id ON exporters(user_id);
```

---

### **5. FARMS**
**Descripción:** Fincas agrícolas registradas por productores.

```sql
CREATE TABLE farms (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  producer_id UUID NOT NULL REFERENCES producers(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  municipality VARCHAR(100) NOT NULL,
  vereda VARCHAR(100),
  latitude NUMERIC(11, 8) NOT NULL,
  longitude NUMERIC(11, 8) NOT NULL,
  main_crop VARCHAR(100),
  total_area NUMERIC(10, 2),  -- hectáreas
  description TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

CREATE INDEX idx_farms_producer_id ON farms(producer_id);
CREATE INDEX idx_farms_location ON farms(latitude, longitude);
CREATE INDEX idx_farms_is_active ON farms(is_active);
```

**Notas:**
- `latitude` y `longitude`: NUMERIC(11,8) para máxima precisión geográfica
- Usar spatial index si se necesita búsqueda por proximidad

---

### **6. PLOTS**
**Descripción:** Lotes agrícolas dentro de fincas.

```sql
CREATE TABLE plots (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  farm_id UUID NOT NULL REFERENCES farms(id) ON DELETE CASCADE,
  name VARCHAR(255) NOT NULL,
  crop VARCHAR(100) NOT NULL,
  area NUMERIC(10, 2),  -- hectáreas
  sowing_date DATE NOT NULL,
  expected_harvest_date DATE,
  actual_harvest_date DATE,
  status VARCHAR(50) DEFAULT 'planning' CHECK (status IN ('planning', 'growing', 'ready', 'harvested')),
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

CREATE INDEX idx_plots_farm_id ON plots(farm_id);
CREATE INDEX idx_plots_status ON plots(status);
CREATE INDEX idx_plots_sowing_date ON plots(sowing_date);
```

---

### **7. ACTIVITIES**
**Descripción:** Registro de actividades agrícolas (siembra, fertilización, cosecha, etc.)

```sql
CREATE TABLE activities (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plot_id UUID NOT NULL REFERENCES plots(id) ON DELETE CASCADE,
  type VARCHAR(50) NOT NULL CHECK (type IN (
    'sowing', 'fertilization', 'irrigation', 'pest_control', 'harvest', 'other'
  )),
  activity_date DATE NOT NULL,
  notes TEXT,
  location_latitude NUMERIC(11, 8),
  location_longitude NUMERIC(11, 8),
  metadata JSONB,  -- Datos adicionales según tipo de actividad
  offline_id VARCHAR(255),  -- Para sincronización offline
  synced_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_activities_plot_id ON activities(plot_id);
CREATE INDEX idx_activities_type ON activities(type);
CREATE INDEX idx_activities_date ON activities(activity_date);
```

**Notas:**
- `metadata` (JSONB): Permite almacenar datos específicos sin migración de schema
  - Ejemplo: `{"fertilizer_name": "Urea", "quantity": "50kg", "cost": "120000"}`
- `offline_id`: Para sincronización desde app (WatermelonDB genera IDs locales)
- `synced_at`: Marca cuándo se sincronizó con servidor

---

### **8. ACTIVITY_IMAGES**
**Descripción:** Imágenes/evidencias de actividades.

```sql
CREATE TABLE activity_images (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  activity_id UUID NOT NULL REFERENCES activities(id) ON DELETE CASCADE,
  image_url VARCHAR(500) NOT NULL,
  filename VARCHAR(255),
  file_size BIGINT,
  mime_type VARCHAR(50),
  alt_text TEXT,
  uploaded_by UUID REFERENCES users(id),
  uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_activity_images_activity_id ON activity_images(activity_id);
```

**Notas:**
- `image_url`: URL en S3 o similar (https://bucket.s3.amazonaws.com/...)
- `file_size`: En bytes, para validación
- `mime_type`: image/jpeg, image/png, etc.

---

### **9. QR_CODES**
**Descripción:** Códigos QR únicos por lote para trazabilidad.

```sql
CREATE TABLE qr_codes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plot_id UUID NOT NULL UNIQUE REFERENCES plots(id) ON DELETE CASCADE,
  code VARCHAR(500) UNIQUE NOT NULL,
  qr_url VARCHAR(500),  -- URL pública: https://agritrace.com/trace/{code}
  scans_count INT DEFAULT 0,
  last_scanned_at TIMESTAMP,
  is_active BOOLEAN DEFAULT true,
  generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  expires_at TIMESTAMP
);

CREATE INDEX idx_qr_codes_plot_id ON qr_codes(plot_id);
CREATE INDEX idx_qr_codes_code ON qr_codes(code);
```

**Notas:**
- `code`: Puede ser UUID o hash único
- `qr_url`: Generado automáticamente
- `scans_count`: Métrica útil para analytics

---

### **10. CERTIFICATES**
**Descripción:** Certificaciones asociadas a lotes.

```sql
CREATE TABLE certificates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plot_id UUID NOT NULL REFERENCES plots(id) ON DELETE CASCADE,
  type VARCHAR(100) NOT NULL CHECK (type IN (
    'organic', 'fair_trade', 'ica', 'rainforest', 'other'
  )),
  issue_date DATE NOT NULL,
  expiry_date DATE,
  document_url VARCHAR(500),
  document_filename VARCHAR(255),
  status VARCHAR(50) DEFAULT 'pending' CHECK (status IN (
    'pending', 'verified', 'expired', 'revoked'
  )),
  verified_by UUID REFERENCES admins(id),
  verified_at TIMESTAMP,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_certificates_plot_id ON certificates(plot_id);
CREATE INDEX idx_certificates_status ON certificates(status);
CREATE INDEX idx_certificates_expiry_date ON certificates(expiry_date);
```

---

### **11. ADMINS**
**Descripción:** Roles y permisos de administradores.

```sql
CREATE TABLE admins (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
  permissions TEXT ARRAY,  -- ['manage_users', 'verify_certificates', 'view_reports']
  last_login TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_admins_user_id ON admins(user_id);
```

---

### **12. AUDIT_LOGS**
**Descripción:** Log de todas las acciones importantes para auditoría.

```sql
CREATE TABLE audit_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id),
  action VARCHAR(100) NOT NULL,  -- 'CREATE', 'UPDATE', 'DELETE', 'LOGIN', etc.
  entity_type VARCHAR(100),  -- 'farm', 'plot', 'activity', 'certificate'
  entity_id UUID,
  old_values JSONB,
  new_values JSONB,
  ip_address INET,
  user_agent TEXT,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

CREATE INDEX idx_audit_logs_user_id ON audit_logs(user_id);
CREATE INDEX idx_audit_logs_action ON audit_logs(action);
CREATE INDEX idx_audit_logs_entity ON audit_logs(entity_type, entity_id);
CREATE INDEX idx_audit_logs_timestamp ON audit_logs(timestamp);
```

---

## 🔐 CONSTRAINTS & RELACIONES

| Relación | Tipo | Cascada |
|---|---|---|
| USERS → PRODUCERS | 1:1 | ON DELETE CASCADE |
| USERS → COOPERATIVES | 1:1 | ON DELETE CASCADE |
| USERS → EXPORTERS | 1:1 | ON DELETE CASCADE |
| USERS → ADMINS | 1:1 | ON DELETE CASCADE |
| PRODUCERS → FARMS | 1:N | ON DELETE CASCADE |
| FARMS → PLOTS | 1:N | ON DELETE CASCADE |
| PLOTS → ACTIVITIES | 1:N | ON DELETE CASCADE |
| PLOTS → QR_CODES | 1:1 | ON DELETE CASCADE |
| PLOTS → CERTIFICATES | 1:N | ON DELETE CASCADE |
| ACTIVITIES → ACTIVITY_IMAGES | 1:N | ON DELETE CASCADE |
| ADMINS → CERTIFICATES | N:1 | SET NULL |

---

## 📊 ÍNDICES CRÍTICOS

```sql
-- Performance críticos
CREATE INDEX idx_farms_producer_id ON farms(producer_id);
CREATE INDEX idx_plots_farm_id ON plots(farm_id);
CREATE INDEX idx_activities_plot_id ON activities(plot_id);
CREATE INDEX idx_qr_codes_code ON qr_codes(code);
CREATE INDEX idx_certificates_plot_id ON certificates(plot_id);

-- Búsquedas frecuentes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_plots_status ON plots(status);
CREATE INDEX idx_activities_date ON activities(activity_date);

-- Auditoría
CREATE INDEX idx_audit_logs_timestamp ON audit_logs(timestamp);
CREATE INDEX idx_audit_logs_action ON audit_logs(action);
```

---

## 🔄 SINCRONIZACIÓN OFFLINE

### Estrategia con WatermelonDB

Para funcionar en modo offline, los datos se sincronizarán así:

```
App Offline (WatermelonDB)
    ↓ (enqueue cambios)
    ↓ (cuando hay conexión)
API Backend
    ↓ (procesa cambios)
PostgreSQL
```

**Campos necesarios para sincronización:**
- `offline_id`: Identificador local generado por cliente
- `synced_at`: Timestamp de última sincronización
- `is_pending`: Boolean (true si no está sincronizado)
- `last_modified`: Timestamp local

---

## 🌐 CONFIGURACIÓN RECOMENDADA

### PostgreSQL 14+
```sql
-- Configurar para máxima durabilidad
ALTER SYSTEM SET fsync = on;
ALTER SYSTEM SET full_page_writes = on;
ALTER SYSTEM SET wal_level = replica;
```

### Backups
- **Diario:** Full backup cada 24 horas
- **Hourly:** WAL archiving
- **Disaster Recovery:** Backup en S3 cada 6 horas

### Connection Pooling
```
PgBouncer o Drizzle ORM connection pool
- Max connections: 20 por réplica
- Idle timeout: 300 segundos
```

---

## 🔒 SEGURIDAD

### Encryption
- ✅ SSL/TLS en tránsito (todas las conexiones)
- ✅ Passwords hasheados con bcrypt
- ✅ JSONB data encriptado si es sensible (AES-256)

### Row Level Security (RLS)
```sql
-- Ejemplo: Productor solo ve sus propias fincas
ALTER TABLE farms ENABLE ROW LEVEL SECURITY;

CREATE POLICY producer_own_farms ON farms
  USING (producer_id IN (
    SELECT id FROM producers WHERE user_id = current_user_id
  ));
```

---

## 📈 ESCALABILIDAD

### Futuro (Fase 2+)
- **Sharding:** Por `producer_id` si crece mucho
- **Read Replicas:** Para consultas (trazabilidad pública)
- **TimescaleDB:** Si hay muchas actividades (timeseries data)

---

## ✅ CHECKLIST IMPLEMENTACIÓN

- [ ] Crear tablas en orden (respetando FKs)
- [ ] Crear índices
- [ ] Configurar RLS (Row Level Security)
- [ ] Crear triggers para `updated_at`
- [ ] Crear funciones de auditoría
- [ ] Configurar backups automáticos
- [ ] Crear roles de BD (readonly, app, admin)
- [ ] Testing con datos de prueba
