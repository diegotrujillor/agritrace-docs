# Decisión: Almacenamiento Offline para Flutter

**Fecha de decisión**: Mayo 2026  
**Status**: Aprobado para MVP  
**Responsable**: Equipo Frontend (Flutter)

## Problema

La aplicación AgriTrace debe funcionar en entornos con conectividad intermitente (3G/4G en zonas rurales). Los productores agrícolas necesitan:
- Registro de actividades sin conexión
- Sincronización automática cuando hay conexión
- No perder datos entre desconexiones

## Opciones Evaluadas

| Opción | Ventajas | Desventajas | Decisión |
|--------|----------|-------------|----------|
| **WatermelonDB** | Mejor rendimiento, batching automático, soporte Dart/Flutter, ORM completo | Dependencia externa, curva de aprendizaje | ✅ **ELEGIDA** |
| **Hive** | Rápido, simple, schema-less | No tiene sincronización built-in, más trabajo manual | ❌ |
| **SQLite** | Estándar, amplio soporte | Sin sincronización, más boilerplate | ❌ |
| **Drift (SQLite wrapper)** | Type-safe SQL, buen ORM | No sincronización, similar a SQLite | ❌ |

## Decisión Final: WatermelonDB

### Por qué WatermelonDB

1. **Sincronización integrada**: Push/pull automático con servidor
2. **Batching optimizado**: Sincroniza múltiples cambios en una llamada
3. **Offline-first**: Diseñado específicamente para aplicaciones offline
4. **Observables con RxDart**: Integración natural con Flutter
5. **Relationships**: Manejo automático de relaciones entre tablas
6. **Compatibilidad**: Funciona con Node.js en el backend

### Arquitectura de Sincronización

```
┌─────────────────┐
│   Flutter App   │
│  (WatermelonDB) │
└────────┬────────┘
         │
    ┌────▼────┐
    │ Detector │ ← Detecta cambios locales
    │ de Cambios
    └────┬────┘
         │
    ┌────▼──────────────┐
    │ Sync Engine       │
    │ (On-demand)       │
    └────┬──────────────┘
         │
    ┌────▼──────────────────────┐
    │  Sync Protocol             │
    │  - Upload local changes    │
    │  - Download remote changes │
    │  - Resolve conflicts       │
    └────┬──────────────────────┘
         │
    ┌────▼─────────────┐
    │  API Backend      │
    │  (Node.js)        │
    └───────────────────┘
```

## Esquema WatermelonDB

### Estructuras de Datos

```javascript
// Modelo: Finca
{
  id: string (UUID)
  name: string
  municipio: string
  vereda: string
  latitude: number
  longitude: number
  mainCrop: string
  area: number (hectáreas)
  
  // Campos de sincronización
  _status: 'created' | 'updated' | 'synced'
  _changes: string[] (track qué campos cambiaron)
  created_at: ISO timestamp
  updated_at: ISO timestamp (se actualiza en cada cambio local)
  synced_at: ISO timestamp | null
}

// Modelo: Lote
{
  id: string (UUID)
  farm_id: string (FK)
  name: string
  area: number
  planted_date: date
  expected_harvest: date
  status: 'preparing' | 'planted' | 'growing' | 'harvested'
  
  _status: 'created' | 'updated' | 'synced'
  updated_at: ISO timestamp
  synced_at: ISO timestamp | null
}

// Modelo: Actividad
{
  id: string (UUID)
  plot_id: string (FK)
  activity_type: 'irrigation' | 'fertilizer' | 'pesticide' | 'harvest' | 'other'
  description: string
  date: ISO timestamp
  location: { latitude, longitude }
  photos: string[] (URIs locales)
  
  _status: 'created' | 'updated' | 'synced'
  updated_at: ISO timestamp
  synced_at: ISO timestamp | null
}

// Tabla de Sincronización (metadatos)
{
  id: string
  last_sync: ISO timestamp | null
  pending_count: number
  conflict_count: number
  last_error: string | null
}
```

## Estrategia de Sincronización

### 1. Cambios Locales
- Cuando el usuario guarda datos, se marcan con `_status: 'created'` o `'updated'`
- Se registra `updated_at` con la hora local
- Se almacenan en WatermelonDB inmediatamente

### 2. Sincronización Manual
```dart
// Código en Flutter
syncEngine.sync();
// Detecta todos los registros con _status != 'synced'
// Agrupa cambios por entidad
// Envía al API en un batch
```

### 3. En el Servidor (Node.js)
```javascript
// El API recibe cambios y:
// 1. Valida conflictos (si otro usuario cambió el mismo dato)
// 2. Aplica cambios a PostgreSQL
// 3. Retorna:
//    - Nuevas versiones de datos sincronizados
//    - IDs de conflictos detectados
//    - Timestamp del servidor
```

### 4. En Flutter (Después de Sync)
```dart
// El cliente recibe respuesta:
// - Actualiza _status a 'synced'
// - Actualiza synced_at con timestamp del servidor
// - Solicita descargar cambios de otros usuarios
// - Resuelve conflictos con estrategia última-escritura-gana
```

## Conflictos

**Estrategia de resolución**: Última escritura gana (Last-Write-Wins)

```
Usuario A en teléfono 1: Modifica actividad en 14:30 (sin conexión)
Usuario B en teléfono 2: Modifica misma actividad en 14:45 (con conexión)

Sincronización:
- A intenta sincronizar: 14:50 (cuando recupera conexión)
- B ya sincronizó a las 14:45

Servidor compara timestamps:
- B.updated_at (14:45) > A.updated_at (14:30)
- ✅ Acepta cambios de B
- ⚠️ A recibe notificación: "Cambios en conflicto, versión en servidor es más reciente"

Cliente A:
- Muestra alerta: "Tu cambio fue sobrescrito por otro usuario"
- Opción: Recargar desde servidor o guardar como nueva versión
```

## Implementación MVP

### Fase 1 (Semana 1-2)
- [ ] Integrar WatermelonDB en proyecto Flutter
- [ ] Crear modelos para Finca, Lote, Actividad
- [ ] Implementar sincronización básica (push de cambios)
- [ ] **NEW**: SMS/USSD fallback para alertas (2 de 4 stakeholders sin smartphone)

### Fase 2 (Semana 3)
- [ ] Implementar descarga de cambios remotos
- [ ] Agregar resolución de conflictos
- [ ] Testing de sincronización offline-online
- [ ] **NEW**: Indicador visual de estado offline/syncing

### Fase 3 (Semana 4+)
- [ ] Encriptación de datos locales
- [ ] Compresión de media (fotos) antes de sincronizar
- [ ] Análisis de uso de almacenamiento
- [ ] **NEW**: Climate alerts integration (if partner API available)

## Endpoints API Requeridos para Sincronización

```yaml
POST /api/v1/sync
  Body:
    changes:
      - entity: 'Farm'
        id: 'uuid'
        action: 'create' | 'update'
        data: { ... }
  Response:
    success: boolean
    synced: [{ entity, id, version, synced_at }]
    conflicts: [{ entity, id, server_version, client_version }]
    timestamp: ISO timestamp

GET /api/v1/sync/changes?since=<timestamp>
  Response:
    changes: [{ entity, id, action, data, synced_at }]
    timestamp: ISO timestamp
```

## Referencias

- WatermelonDB Docs: https://nozbe.github.io/WatermelonDB/
- Backend Sync Protocol: `/02-documentacion-tecnica/03-api/01-especificacion-openapi.yaml` (endpoints `/sync`)
- Base de Datos: `/02-documentacion-tecnica/02-base-de-datos/01-diseno-base-datos.md` (campos `_status`, `updated_at`)

## Aprobación

- ✅ Equipo Backend: Aprobado (API endpoints listos)
- ✅ Equipo Frontend: Aprobado (WatermelonDB integrable)
- ✅ Equipo Producto: Aprobado (offline-first alineado con requisitos MVP)
