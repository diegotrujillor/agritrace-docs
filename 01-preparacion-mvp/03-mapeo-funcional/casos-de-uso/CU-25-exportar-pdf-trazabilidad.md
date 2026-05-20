# CU-25 — Exportar PDF de trazabilidad por lote (con foto + actividades)

| Campo | Valor |
|---|---|
| **ID** | CU-25 |
| **Actor primario** | Productor |
| **Prioridad MVP** | MUST |
| **Disparador** | Diego toca **"Exportar PDF de trazabilidad"** en la Pantalla 9 (Vista lote). |
| **Endpoints invocados** | Ninguno externo — el PDF se genera **client-side en Flutter** (paquetes `pdf` + `printing`). Lee datos locales de WatermelonDB; si está online, refresca primero con `plotsGetById` + `activitiesListByPlot`. |
| **Pantallas** | Pantalla 9 (Vista lote) → diálogo Share-sheet con el PDF. |
| **RFs cubiertos** | RF-08 (exportar reporte PDF de trazabilidad). |

## Preconditions
- Diego está autenticado.
- Existe el lote propio con ≥1 actividad (idealmente con foto).
- WatermelonDB tiene los datos sincronizados (el PDF puede generarse offline si los datos ya están locales).

## Escenario principal (Main Success Scenario)
1. Diego está en **Pantalla 9 — Vista lote**.
2. Toca **"Exportar PDF de trazabilidad"**.
3. App muestra un loader breve mientras `pdf_traceability_service` arma el documento:
   - Encabezado con marca AgriTrace.
   - Datos del productor (nombre, email, teléfono).
   - Datos de la finca (nombre, cultivo principal, área, coordenadas).
   - Datos del lote (nombre, cultivo, variedad, área, status).
   - Timeline de actividades en orden cronológico (ASC en el PDF para lectura): fecha (formato local es-CO), tipo, descripción, miniatura de foto si existe.
4. Se abre el Share-sheet Android con el archivo `trazabilidad-<lote>-<YYYYMMDD>.pdf`.
5. Diego elige destino (WhatsApp, Drive, email, impresión local).
6. Snackbar: "PDF generado".

## Flujos alternos
- **A. Lote sin actividades** → el PDF se genera igual pero con sección "Sin actividades registradas". UX puede advertir antes ("¿Generar PDF sin actividades?").
- **B. Fotos pesadas o muchas (>10)** → el PDF puede demorar varios segundos en generarse; mostrar loader. Considerar limitar a las últimas N fotos.
- **C. Sin almacenamiento disponible** en el dispositivo → snackbar "Sin espacio en el dispositivo".
- **D. Sin conexión** → el PDF se genera con datos locales. **El PDF es offline-capable** (decisión arquitectónica MVP).
- **E. Cancelar Share-sheet** → el archivo temporal puede quedar en cache (validar limpieza).

> **Limitación de prueba manual:** Diego debe comparar el PDF contra la UI de Pantalla 9 visualmente. No hay validación automatizada del contenido del PDF en el smoke-test. Generación de PDF se valida con tests de widget/golden en mobile (cobertura 84.6% — ver mobile CHANGELOG entrada `2026-05-20 — test: cobertura global a 84.6 %`).

## Postcondition
- Archivo PDF generado en almacenamiento temporal del dispositivo.
- No hay cambio en backend ni en DB local (operación de lectura + render).
- Si Diego compartió el archivo, llega a su destino elegido.

## Acceptance criteria (Given/When/Then)
- **Given** Diego tiene un lote con 5 actividades y 3 fotos, **When** toca "Exportar PDF", **Then** se genera el PDF con las 5 actividades y las 3 miniaturas en ≤10 s.
- **Given** está offline, **When** Diego exporta el PDF, **Then** la operación funciona usando solo datos locales.
- **Given** Diego comparte el PDF por WhatsApp, **When** abre la conversación destino, **Then** el archivo se adjunta correctamente y abre sin corrupción.
- **Given** el lote no tiene fotos, **When** se genera el PDF, **Then** la sección de actividades no muestra placeholders rotos.

## Estado de prueba
- **Estado:** 🟡 pendiente
- **Fecha de prueba:**
- **Versión APK probada:**
- **Notas de Diego:**
  > <espacio para anotar lo observado> — **abrir el PDF generado y revisar visualmente** que finca/lote/actividades/fotos están presentes y legibles. Probar compartir vía WhatsApp como prueba final.

## Bugs históricos relevantes
- Ninguno documentado específico al servicio de PDF en CHANGELOG. La cobertura de tests de `pdf_traceability_service` es ≥80% según el reporte `docs/COVERAGE.md` del mobile.
