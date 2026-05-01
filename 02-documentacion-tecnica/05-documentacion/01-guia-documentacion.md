# 🤖 AGENT DOCUMENTATION GUIDE — AgriTrace

**Versión:** 1.0  
**Propósito:** Sistema de prompts y procedimientos para que agentes IA documenten código automáticamente

---

## 📌 OVERVIEW

Este documento describe cómo usar agentes IA (como Claude) para:
1. **Documentar automáticamente** código nuevo
2. **Generar OpenAPI specs** desde código
3. **Validar código** contra mejores prácticas
4. **Mantener documentación** sincronizada con código
5. **Generar changelogs** automáticamente

---

## 🎯 CASOS DE USO DE AGENTES

### Caso 1: Documentar Nuevo Endpoint
**Trigger:** Se agrega un endpoint en `src/api/*/[module].routes.ts`

**Tarea del Agente:**
```markdown
1. Leer el código del endpoint
2. Generar JSDoc comment
3. Generar sección en OpenAPI spec
4. Actualizar CHANGELOG.md
5. Validar que cumple best practices
```

**Prompt Template:**
```
Eres un experto en documentación de APIs REST. Analiza el siguiente código de endpoint:

[CÓDIGO DEL ENDPOINT]

Por favor:
1. Genera un JSDoc comment completo
2. Genera la sección correspondiente en OpenAPI 3.0 YAML
3. Identifica dependencias, validaciones y errores posibles
4. Sugiere mejoras si detectas anti-patterns

Formato de respuesta:
## JSDoc
[JSDoc aquí]

## OpenAPI
[YAML aquí]

## Validaciones
[Lista de validaciones]

## Anti-patterns Detectados
[Si hay, listar]
```

---

### Caso 2: Documentar Servicio Nuevo
**Trigger:** Se agrega una clase service en `src/services/*.ts`

**Tarea del Agente:**
```markdown
1. Analizar métodos públicos
2. Generar README.md de servicio
3. Documentar inyecciones de dependencia
4. Listar relaciones con otros servicios
5. Generar ejemplos de uso
```

**Prompt Template:**
```
Eres un experto en arquitectura de software. Analiza la siguiente clase de servicio:

[CÓDIGO DEL SERVICE]

Por favor genera:
1. README.md para este servicio con:
   - Descripción
   - Métodos públicos documentados
   - Ejemplos de uso
   - Inyecciones de dependencia requeridas

2. Diagrama de dependencias (formato markdown)

3. Test outline (qué debería testearse)

Formato:
## README
[Markdown aquí]

## Dependencias
[Diagrama aquí]

## Test Cases Recomendados
[Lista aquí]
```

---

### Caso 3: Validar Código Contra Best Practices
**Trigger:** PR enviado o commit hecho

**Tarea del Agente:**
```markdown
1. Revisar contra DEVELOPMENT_GUIDELINES.md
2. Detectar anti-patterns
3. Sugerir mejoras
4. Validar cobertura de tests
5. Generar reporte
```

**Prompt Template:**
```
Eres un code reviewer experiente en best practices de Node.js/TypeScript y React Native.

Revisa el siguiente código según estas directrices:
[CONTENIDO DE DEVELOPMENT_GUIDELINES.md]

Código a revisar:
[CÓDIGO]

Por favor proporciona:
1. ✅ Lo que está bien hecho
2. ⚠️ Warnings (no es error, pero podría mejorar)
3. ❌ Errores críticos
4. 💡 Sugerencias de mejora

Formato de respuesta:
## ✅ Lo Bien Hecho
- Punto 1
- Punto 2

## ⚠️ Warnings
- Punto 1 (Razón)

## ❌ Errores Críticos
- Punto 1 (Razón, Solución)

## 💡 Sugerencias
- Punto 1

## Resumen
[Párrafo resumen]
```

---

### Caso 4: Generar OpenAPI Documentation Automáticamente
**Trigger:** Cambio en `/src/api/**/*.routes.ts`

**Tarea del Agente:**
```markdown
1. Parsear todas las rutas
2. Extraer métodos, parámetros, respuestas
3. Generar especificación OpenAPI 3.0 YAML
4. Validar consistencia con schema
5. Generar documentación HTML
```

**Prompt Template:**
```
Eres un experto en OpenAPI 3.0 specification. Analiza las siguientes rutas:

[TODAS LAS RUTAS DEL PROYECTO]

Para cada ruta, genera:
1. Documentación OpenAPI 3.0.0 YAML completa
2. Validaciones de input
3. Posibles respuestas de error
4. Ejemplos de request/response

Formato YAML:
```yaml
paths:
  /endpoint:
    method:
      summary: ...
      ...
```

Entrega el archivo completo listo para usar.
```

---

### Caso 5: Generar CHANGELOG Automáticamente
**Trigger:** Merge a `main` branch

**Tarea del Agente:**
```markdown
1. Leer commits desde último release
2. Categorizar cambios (Feature, Fix, Breaking Change)
3. Generar CHANGELOG.md
4. Versionar semánticamente
```

**Prompt Template:**
```
Eres un experto en semantic versioning y CHANGELOG management.

Commits desde último release (v1.0.0):
[LISTA DE COMMITS]

Por favor:
1. Categoriza cada commit como:
   - Feature (nueva funcionalidad)
   - Fix (corrección de bug)
   - Breaking Change (cambio incompatible)
   - Refactor (cambio sin funcionalidad)
   - Docs (solo documentación)

2. Sugiere nueva versión (semver)

3. Genera CHANGELOG.md en formato:
```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- Feature 1
- Feature 2

### Fixed
- Fix 1

### Breaking Changes
- Change 1
```

---

## 📋 WORKFLOW RECOMENDADO

### 1. Diario (End of Day)
```bash
# Agente revisa cambios del día
# 1. Valida código contra best practices
# 2. Genera/actualiza JSDoc
# 3. Reporta issues
```

**Prompts a usar:**
- `code-review-validator`
- `jsdoc-generator`
- `best-practices-check`

### 2. Por PR
```bash
# Agente revisa cada PR
# 1. Code review automático
# 2. Validación de documentación
# 3. Genera changelog entry
```

**Prompts a usar:**
- `pr-code-review`
- `documentation-validator`
- `changelog-entry-generator`

### 3. Semanal
```bash
# Agente genera reportes
# 1. Documentación actualizada?
# 2. Tests cubren cambios?
# 3. OpenAPI spec sincronizado?
```

**Prompts a usar:**
- `documentation-audit`
- `test-coverage-validator`
- `spec-sync-validator`

### 4. Release (Cuando haces merge a main)
```bash
# Agente prepara release
# 1. Genera CHANGELOG
# 2. Valida breaking changes
# 3. Sugiere nueva versión
```

**Prompts a usar:**
- `changelog-generator`
- `breaking-change-detector`
- `version-suggester`

---

## 🔧 PROMPTS REUTILIZABLES

### Prompt 1: Code Review Rápido
```
Revisa este código en máximo 5 minutos:
[CÓDIGO]

Responde solo:
1. ¿Está bien? (sí/no)
2. ¿Qué falta? (lista)
3. ¿Qué va a romper? (lista)
```

### Prompt 2: Generar JSDoc
```
Genera JSDoc completo para:
[FUNCIÓN O MÉTODO]

Incluye:
- Descripción clara
- @param para cada parámetro
- @returns explicando qué retorna
- @throws si puede fallar
- @example de uso
```

### Prompt 3: Generar Test Template
```
Genera test skeleton para:
[FUNCIÓN O MÉTODO]

Usa Jest y TypeScript.
Incluye casos exitosos y de error.
```

### Prompt 4: Documentación de API
```
Genera documentación HTTP para:
Método: [GET/POST/PUT/DELETE]
Path: [path]
Auth: [requerido? sí/no]
Body: [estructura]
Response: [estructura]

Formato: Markdown con ejemplos curl
```

### Prompt 5: Validar Schema
```
Valida que el siguiente código cumpla el schema:

Schema:
[SCHEMA EN TYPESCRIPT O JSON]

Código:
[CÓDIGO]

¿Cumple? ¿Qué falta?
```

---

## 📊 PLANTILLA DE REPORTE DE AGENTE

Cada vez que un agente documente algo, debe generar este reporte:

```markdown
# Reporte de Documentación - [Fecha]

**Agente:** [Nombre del agente]  
**Trigger:** [Qué causó la ejecución]  
**Tiempo:** [Cuánto tardó]

## Cambios Realizados
- [ ] Archivo 1 - Acción
- [ ] Archivo 2 - Acción

## Validaciones
- ✅ Code review: OK
- ✅ Best practices: OK
- ✅ TypeScript: OK
- ⚠️ Tests: Parcial (80%)

## Issues Detectados
1. Issue 1 (Severidad: crítica)
2. Issue 2 (Severidad: media)

## Archivos Modificados
- `docs/API.md`
- `src/services/farm.service.ts` (JSDoc actualizado)
- `CHANGELOG.md`

## Próximos Pasos
- [ ] Ejecutar tests
- [ ] Revisar cambios manualmente
- [ ] Mergear a develop

---
```

---

## 🎓 EJEMPLOS DE EJECUCIÓN

### Ejemplo 1: Documentar Endpoint Nueva

**Input:**
```typescript
// src/api/plots/plots.routes.ts
router.post('/:plotId/qr/generate', authenticate, generateQR);

export const generateQR = async (req: Request, res: Response) => {
  const { plotId } = req.params;
  const qr = await qrService.generate(plotId, req.user.id);
  res.status(201).json({ data: qr });
};
```

**Agent Output:**
```markdown
## JSDoc
/**
 * Generar código QR para un lote
 * Crea un código QR único y verificable para la trazabilidad
 * 
 * @param {Request} req - Request con plotId en params
 * @param {Response} res - Response HTTP
 * @throws {UnauthorizedError} Si no está autenticado
 * @throws {NotFoundError} Si el lote no existe
 * @throws {ValidationError} Si el lote ya tiene QR
 */

## OpenAPI
```yaml
/plots/{plotId}/qr/generate:
  post:
    tags:
      - QR
    summary: Generar código QR para un lote
    security:
      - BearerAuth: []
    parameters:
      - name: plotId
        in: path
        required: true
        schema:
          type: string
          format: uuid
    responses:
      '201':
        description: Código QR generado
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/QRCode'
      '401':
        description: No autenticado
      '404':
        description: Lote no encontrado
```

## Validaciones
- ✅ Autenticación presente
- ✅ Errores documentados
- ⚠️ Validación de plotId en servicio, no en controller

## Test Cases Sugeridos
- POST con plotId válido → 201
- POST sin auth → 401
- POST con plotId inválido → 404
- POST con lote que ya tiene QR → 400
```

---

## 🚀 INTEGRACIÓN CON CI/CD

### GitHub Actions Example
```yaml
name: Auto-Documentation

on: [push, pull_request]

jobs:
  document:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Check for new files
        id: changes
        run: |
          git diff --name-only origin/main | grep -E "src/api|src/services" || echo "no_changes"
      
      - name: Run Documentation Agent
        if: steps.changes.outputs.result != 'no_changes'
        run: |
          # Llamar a agente
          # npx claude-agent document-code [modified-files]
          echo "Documentation generated"
      
      - name: Code Review Agent
        run: |
          # Llamar a agente de code review
          echo "Code review completed"
      
      - name: Commit changes
        run: |
          git config --local user.email "agent@agritrace.com"
          git config --local user.name "AgriTrace Docs Bot"
          git add .
          git commit -m "docs: auto-generated documentation" || echo "No changes to commit"
          git push
```

---

## ✅ CHECKLIST PARA AGENTES

Antes de que un agente haga commit:
- [ ] ¿Validó sintaxis?
- [ ] ¿Cumple best practices?
- [ ] ¿OpenAPI spec sincronizado?
- [ ] ¿JSDoc completo?
- [ ] ¿Tests mencionados?
- [ ] ¿Mensaje de commit descriptivo?
- [ ] ¿CHANGELOG actualizado?
- [ ] ¿No hay conflictos?

---

## 📞 CUANDO NO USAR AGENTES

❌ **No uses agentes para:**
- Decisiones arquitectónicas (eso es humano)
- Cambios de DB schema (requiere migración)
- Cambios de seguridad crítica
- Refactoring de lógica de negocio compleja
- Borrado de código (siempre revisar humano)

✅ **Úsalo para:**
- Documentación
- Validación de style/lint
- Generación de tests template
- OpenAPI docs
- CHANGELOG
- Code review automático

---

## 🔒 SEGURIDAD DE AGENTES

**Importantes:**
1. **Tokens limitados:** Agente solo puede hacer commits en branches específicos
2. **Auditoría:** Todos los cambios de agente deben logged
3. **Validación:** Cambios de agente requieren aprobación humana antes de merge a main
4. **Permisos:** Agente solo puede modificar archivos de documentación

---

## 📚 REFERENCIAS

- OpenAPI 3.0: https://spec.openapis.org/oas/v3.0.3
- JSDoc: https://jsdoc.app/
- Semantic Versioning: https://semver.org/
- CHANGELOG: https://keepachangelog.com/

---

**Última revisión:** 30 de Abril 2026  
**Próxima revisión:** Cuando se agreguen nuevos procesos automáticos
