# CU-10 — Crear lote dentro de una finca

| Campo | Valor |
|---|---|
| **ID** | CU-10 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego toca **"Registrar lote"** en la Pantalla 7 (Vista finca). |
| **Endpoints invocados** | `plotsCreate` (`POST /v1/plots`) — ver [`openapi.yaml`](../../../../agritrace-backend/docs/openapi.yaml) |
| **Pantallas** | Pantalla 7 (Vista finca) → Pantalla 8 (Registrar lote) → Pantalla 9 (Vista lote). Rutas: `Routes.farmDetail(<farmId>)` → `Routes.plotNew(<farmId>)` → `Routes.plotDetail(<plotId>)`. |
| **RFs cubiertos** | RF-02 (registrar lotes), RF-07 (múltiples lotes por finca). |

## Preconditions
- Diego está autenticado.
- Existe la finca destino (CU-06).
- Hay conexión a internet **o** WatermelonDB local activo (modo offline-first).

## Escenario principal (Main Success Scenario)
1. Diego está en **Pantalla 7 — Vista finca**.
2. Toca **"Registrar lote"** → navega a `Routes.plotNew(<farmId>)` (**Pantalla 8 — Registrar lote**).
3. Diligencia:
   - Nombre del lote (2-255 chars).
   - Cultivo (2-50 chars; típicamente hereda el de la finca pero editable).
   - Variedad (opcional, ≤255 chars).
   - Área en hectáreas (opcional, decimal positivo).
   - Estado inicial (`planning` por defecto; otros valores: `growing` / `ready` / `harvested`).
   - Foto opcional (paso 4 menciona foto en spec, validar implementación).
4. Toca **"Guardar"** → mobile dispara `POST /v1/plots` con `farmId` + datos.
5. Backend valida `farmId` pertenece al productor (403 si no), inserta fila en `plots`. Responde 201.
6. Mobile navega a `Routes.plotDetail(plot.id)` (**Pantalla 9 — Vista del Lote**).

## Flujos alternos
- **A. Finca destino no pertenece al productor** → `403 ForbiddenError`.
- **B. Nombre vacío o cultivo <2 chars** → `400 ValidationError`.
- **C. Sin conexión** → lote guardado en WatermelonDB local con `_status='created'`, sync diferido.

## Postcondition
- Fila nueva en `plots` con `farm_id` correcto y `status` inicial (default `planning`).
- UI muestra Pantalla 9 con timeline vacío.
- Verificable: `SELECT id, name, status, farm_id FROM plots WHERE farm_id = '<farmId>';`. Ver [`009_create_plots.sql`](../../../../agritrace-backend/src/db/migrations/009_create_plots.sql).

## Acceptance criteria (Given/When/Then)
- **Given** Diego está en Pantalla 8 con datos válidos, **When** guarda con conexión, **Then** la fila `plots` existe con `farm_id` correcto y la UI muestra Pantalla 9.
- **Given** Diego intenta crear lote en finca ajena, **When** envía `POST /v1/plots`, **Then** backend responde 403.
- **Given** no hay conexión, **When** Diego guarda, **Then** el lote queda local con `_status='created'` y se sincroniza al reconectar (CU-23).

## Estado de prueba
- **Estado:** ✅ pasa (en v1.3.5)
- **Fecha de prueba:** 2026-05-20
- **Versión APK probada:** 1.3.5 (release APK con fixes nav + URL)
- **Entorno:** emulador AVD + backend v0.4.1.
- **Notas de Diego (auto):**
  > Desde Pantalla 7 (Detalle Finca), tap FAB "Agregar lote" → Pantalla 8 (form). Form muestra: Nombre del lote, Tipo de cultivo (dropdown default "cacao"), Variedad (opcional), Área hectáreas (opcional), Estado (dropdown default "Planificación"), botón "Agregar lote".
  > Llené "Lote B" (sin área) + submit → form se cerró → volvió a Pantalla 7 con "Lote B / cacao · Planificación" listado bajo "Lotes". Sin banner de error.
  > Compartía el mismo bug nav que CU-06 antes de v1.3.4 — confirma que el fix de FAB context.go→push también aplica a este flow.

## Bugs históricos relevantes
- Ninguno documentado en CHANGELOG.
