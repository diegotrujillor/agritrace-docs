# 03-api — Especificación y guía de consumo

## Especificación canónica

La spec **viva** de la API REST de AgriTrace vive en el repo del backend:

> **[`agritrace-backend/docs/openapi.yaml`](https://github.com/diegotrujillor/agritrace-backend/blob/main/docs/openapi.yaml)**

Es OpenAPI 3.0.3, valida en CI con `@redocly/cli`, y refleja
exactamente las rutas implementadas en `src/api/*` y los esquemas Zod
en `src/api/*/*.validations.ts`. Cualquier consulta sobre el
contrato real (campos requeridos, códigos de respuesta, formato de
ID, enums) debe hacerse contra ese archivo.

Hermana legible: **[`agritrace-backend/docs/API.md`](https://github.com/diegotrujillor/agritrace-backend/blob/main/docs/API.md)** — tabla de los
30 endpoints agrupados por tag (`health`, `auth`, `users`, `farms`,
`plots`, `activities`, `alerts`, `sync`) + envelope + clases de error.

## ¿Hay un endpoint live para Swagger UI?

**No, todavía no.** Hoy el spec se consume offline: se clona el repo o
se abre el archivo en GitHub. Ver opciones de render más abajo.

Servirlo como endpoint HTTP queda planeado para **Sprint 6+**
(ver "Roadmap" abajo).

## Cómo ver la spec (hoy)

### 1) En GitHub (lo más rápido)

GitHub renderiza el YAML como texto plano:
<https://github.com/diegotrujillor/agritrace-backend/blob/main/docs/openapi.yaml>

Para una vista Swagger-UI sobre ese archivo se puede pegar la URL
"raw" en <https://editor.swagger.io>:

```
https://raw.githubusercontent.com/diegotrujillor/agritrace-backend/main/docs/openapi.yaml
```

(Cero infra, cero clones; útil cuando alguien necesita echar un ojo.)

### 2) Redoc local — preview interactivo

```bash
git clone git@github.com:diegotrujillor/agritrace-backend.git
cd agritrace-backend
npx --yes @redocly/cli@latest preview-docs docs/openapi.yaml
# abre http://localhost:8080
```

Render estático a HTML:

```bash
npx --yes @redocly/cli@latest build-docs docs/openapi.yaml -o docs/api.html
open docs/api.html
```

### 3) Swagger UI con Docker

```bash
cd agritrace-backend
docker run --rm -p 8081:8080 \
  -e SWAGGER_JSON=/spec/openapi.yaml \
  -v "$PWD/docs:/spec" \
  swaggerapi/swagger-ui
# abre http://localhost:8081
```

### 4) Generar tipos cliente (opcional)

`openapi-typescript` para sincronizar tipos con la app móvil:

```bash
npx --yes openapi-typescript docs/openapi.yaml -o lib/services/api.types.ts
```

## Probar la API live

Base URLs:

| Entorno | URL |
|---|---|
| Producción | `https://api.agritrace.co/v1` |
| Local dev | `http://localhost:3000/v1` |

Ejemplos cURL (sin auth):

```bash
# Health check
curl -sS https://api.agritrace.co/v1/health | jq

# Registro (Ley 1581 consent obligatorio)
curl -sS -X POST https://api.agritrace.co/v1/auth/register \
  -H 'Content-Type: application/json' \
  -d '{
    "email":"tester@example.com",
    "password":"Pa55word!",
    "fullName":"Juan Gómez",
    "phone":"+573101234567",
    "privacyConsent": true
  }' | jq
```

Postman / Insomnia / Bruno: importar `openapi.yaml` directo desde el
repo del backend; las colecciones se generan solas.

## Política de drift

La spec se actualiza **en el mismo PR** que toca rutas, validaciones,
modelos públicos o códigos de respuesta. El CI corre
`npx @redocly/cli lint docs/openapi.yaml`; un PR que cambia rutas pero
no actualiza `openapi.yaml` debería ser bloqueado en revisión.

Detalle de la política: `agritrace-backend/docs/API.md` → "Política
de drift".

## Roadmap

| Sprint | Acción |
|---|---|
| 6 | Servir Swagger UI como middleware Express en `GET /v1/docs`. Snippet de referencia abajo. |
| 6 | Generar tipos TS automáticamente desde el spec en CI del mobile (consume `openapi.yaml` del backend). |
| 6+ | Añadir `examples:` por endpoint para mejorar la calidad del render. |
| Post-MVP | Versionar la spec por release (`openapi-v0.3.0.yaml`, etc.) si se introducen breaking changes. |

### Boceto del endpoint `/v1/docs` (Sprint 6)

`agritrace-backend`:

```ts
// src/index.ts
import swaggerUi from 'swagger-ui-express';
import YAML from 'yaml';
import fs from 'fs';
import path from 'path';

const openApiDoc = YAML.parse(
  fs.readFileSync(path.join(__dirname, '../docs/openapi.yaml'), 'utf8'),
);

app.use(
  `${API_PREFIX}/docs`,
  swaggerUi.serve,
  swaggerUi.setup(openApiDoc, {
    customSiteTitle: 'AgriTrace API — docs',
  }),
);
```

Add `swagger-ui-express` + `yaml` a `package.json`. Asegurarse de que
el Dockerfile copia `docs/openapi.yaml` junto con `dist/`. Caddy ya
deja pasar cualquier path bajo `/v1/*`; la CSP por defecto debería
permitir el HTML estático.

## Sobre `01-especificacion-openapi.yaml` (legacy)

El archivo `01-especificacion-openapi.yaml` que se encuentra en este
mismo folder es un **artefacto histórico de planeación** (Mayo 2026)
previo a la implementación. Tiene versión `1.0.0` aspiracional,
licencia MIT, contacto genérico, y endpoints que no terminaron de
implementarse en el MVP. **No es la spec viva.** Se conserva como
referencia de diseño temprano y carga un banner de advertencia al
inicio del archivo. Para el contrato actual, ver la spec canónica del
backend.
