# 📋 DEVELOPMENT GUIDELINES — AgriTrace MVP

**Versión:** 1.0  
**Última actualización:** 30 de Abril de 2026  
**Mantener actualizado cuando:** Agregues nuevos patrones o descubras nuevas best practices

---

## 🎯 PRINCIPIOS FUNDAMENTALES

1. **Mobile-First:** App móvil con Flutter (Dart) únicamente. Sin web app, sin React Native. Mobile-only MVP.
2. **Offline-First:** El app debe funcionar sin conexión, sincronizar cuando hay conexión
3. **Security by Default:** Autenticación y autorización en cada request
4. **Simplicity:** Código simple > código clever
5. **Documentation:** Código autoexplicativo + comentarios donde es necesario
6. **Testing:** Todo debe poder testearse

---

## 🏗️ ESTRUCTURA DE CARPETAS

### Backend (Node.js/TypeScript)
```
agritrace-backend/
├── src/
│   ├── api/                      # Controladores y rutas
│   │   ├── auth/
│   │   │   ├── auth.controller.ts
│   │   │   ├── auth.routes.ts
│   │   │   └── auth.validations.ts
│   │   ├── producers/
│   │   ├── farms/
│   │   ├── plots/
│   │   └── activities/
│   │
│   ├── services/                 # Lógica de negocio
│   │   ├── auth.service.ts
│   │   ├── producer.service.ts
│   │   ├── farm.service.ts
│   │   ├── plot.service.ts
│   │   └── activity.service.ts
│   │
│   ├── db/                       # Base de datos
│   │   ├── connection.ts
│   │   ├── migrations/
│   │   │   ├── 001_create_users.sql
│   │   │   ├── 002_create_farms.sql
│   │   │   └── ...
│   │   └── seeds/
│   │       └── dev-data.sql
│   │
│   ├── middleware/               # Middlewares
│   │   ├── auth.middleware.ts
│   │   ├── error-handler.ts
│   │   ├── validation.ts
│   │   ├── rate-limit.ts
│   │   └── audit-log.ts
│   │
│   ├── models/                   # TypeScript interfaces
│   │   ├── user.model.ts
│   │   ├── producer.model.ts
│   │   ├── farm.model.ts
│   │   ├── plot.model.ts
│   │   └── activity.model.ts
│   │
│   ├── utils/                    # Utilidades
│   │   ├── logger.ts
│   │   ├── validators.ts
│   │   ├── formatters.ts
│   │   ├── crypto.ts
│   │   └── errors.ts
│   │
│   ├── config/                   # Configuración
│   │   ├── env.ts
│   │   ├── database.ts
│   │   └── constants.ts
│   │
│   ├── types/                    # Types globales
│   │   ├── express.ts
│   │   └── custom.ts
│   │
│   └── index.ts                  # Entry point
│
├── tests/
│   ├── unit/
│   │   └── services/
│   ├── integration/
│   │   └── api/
│   └── fixtures/
│       └── test-data.ts
│
├── docs/
│   ├── API.md
│   ├── ARCHITECTURE.md
│   ├── DATABASE.md
│   ├── DEVELOPMENT.md
│   └── DEPLOYMENT.md
│
├── .env.example
├── .gitignore
├── package.json
├── tsconfig.json
├── jest.config.js
└── README.md
```

### Frontend Mobile (Flutter / Dart)
```
agritrace-prototype/
├── lib/
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── welcome_screen.dart
│   │   │   ├── login_screen.dart
│   │   │   └── register_screen.dart
│   │   ├── farms/
│   │   │   ├── dashboard_screen.dart
│   │   │   ├── farm_form_screen.dart
│   │   │   └── farm_detail_screen.dart
│   │   ├── plots/
│   │   │   ├── plot_form_screen.dart
│   │   │   └── plot_detail_screen.dart
│   │   └── activities/
│   │       ├── activity_form_screen.dart
│   │       └── activity_timeline_screen.dart
│   │
│   ├── widgets/
│   │   ├── common/
│   │   │   ├── app_button.dart
│   │   │   ├── app_input.dart
│   │   │   ├── app_card.dart
│   │   │   └── offline_indicator.dart
│   │   └── domain/
│   │       ├── farm_card.dart
│   │       └── activity_list_item.dart
│   │
│   ├── navigation/
│   │   ├── app_router.dart
│   │   └── route_names.dart
│   │
│   ├── services/
│   │   ├── api_service.dart
│   │   ├── auth_service.dart
│   │   ├── sync_service.dart
│   │   └── storage_service.dart
│   │
│   ├── database/
│   │   ├── database.dart              # WatermelonDB setup
│   │   ├── models/
│   │   │   ├── farm.dart
│   │   │   ├── plot.dart
│   │   │   └── activity.dart
│   │   └── migrations/
│   │       └── schema.dart
│   │
│   ├── providers/                     # Estado (Provider / Riverpod)
│   │   ├── auth_provider.dart
│   │   ├── farms_provider.dart
│   │   └── sync_provider.dart
│   │
│   ├── utils/
│   │   ├── validators.dart
│   │   ├── formatters.dart
│   │   └── constants.dart
│   │
│   └── main.dart
│
├── test/
│   ├── unit/
│   └── widget/
│
├── pubspec.yaml
├── pubspec.lock
└── README.md
```

---

## ✅ CHECKLIST DE CÓDIGO

### Backend

#### Controladores (Controllers)
- [ ] Validar entrada con Joi/Yup/Zod
- [ ] Manejar errores con try-catch
- [ ] Retornar respuesta en formato standard
- [ ] Loguear acciones críticas
- [ ] Documentar con JSDoc

```typescript
// ✅ CORRECTO
/**
 * Crear una nueva finca
 * @param req - Request con farmInput en body
 * @param res - Response
 * @throws {ValidationError} Si los datos son inválidos
 * @throws {UnauthorizedError} Si no está autenticado
 */
export const createFarm = async (req: Request, res: Response) => {
  try {
    const { error, value } = farmSchema.validate(req.body);
    if (error) {
      return res.status(400).json({ message: error.details[0].message });
    }

    const farm = await farmService.create(value, req.user.id);
    
    logger.info(`Farm created: ${farm.id} by user ${req.user.id}`);
    res.status(201).json({ data: farm });
  } catch (err) {
    errorHandler(err, res);
  }
};

// ❌ INCORRECTO
export const createFarm = async (req, res) => {
  const farm = await Farm.create(req.body);  // ¿Y si falla? ¿Y la validación?
  res.json(farm);
};
```

#### Servicios (Services)
- [ ] Contener lógica de negocio, no lógica HTTP
- [ ] Ser independientes de Express/HTTP
- [ ] Inyectables (dependency injection)
- [ ] Manejar errores específicos
- [ ] Documentados con JSDoc

```typescript
// ✅ CORRECTO
export class FarmService {
  constructor(private db: Database) {}

  async create(farmData: FarmInput, producerId: string): Promise<Farm> {
    // Validación lógica
    if (!farmData.latitude || !farmData.longitude) {
      throw new ValidationError('Coordinates are required');
    }

    // Lógica de negocio
    const farm = {
      id: uuidv4(),
      producerId,
      ...farmData,
      createdAt: new Date(),
    };

    // Persistencia
    return this.db.farms.create(farm);
  }
}

// ❌ INCORRECTO
export const createFarm = async (req, res) => {
  const farm = new Farm(req.body);
  await farm.save();  // Acoplado a modelo ORM
  res.json(farm);
};
```

#### Middlewares
- [ ] Ser específicos (una responsabilidad)
- [ ] No hacer lógica de negocio
- [ ] Documentados

```typescript
// ✅ CORRECTO: Middleware específico
export const authenticateToken = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const token = req.headers.authorization?.split(' ')[1];
  if (!token) {
    return res.status(401).json({ message: 'No token provided' });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET!);
    req.user = decoded;
    next();
  } catch (err) {
    res.status(403).json({ message: 'Invalid token' });
  }
};

// ❌ INCORRECTO: Middleware que hace todo
export const middleware = (req, res, next) => {
  // Autenticación
  // Validación
  // Logging
  // Modificación de datos
  // ... Todo junto
};
```

### Frontend (Flutter / Dart)

#### Widgets
- [ ] Naming: `PascalCase` para widgets
- [ ] Preferir `StatelessWidget` cuando sea posible
- [ ] Usar parámetros tipados en constructores
- [ ] Evitar lógica compleja en `build()`
- [ ] Documentar con comentarios `///`

```dart
// ✅ CORRECTO
/// Tarjeta de actividad agrícola
/// Muestra fecha, tipo, notas e imágenes
class ActivityCard extends StatelessWidget {
  const ActivityCard({
    super.key,
    required this.activity,
    required this.onTap,
    this.isLoading = false,
  });

  final Activity activity;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Card(
        child: Column(
          children: [
            Text(activity.type),
            Text(activity.date.toString()),
          ],
        ),
      ),
    );
  }
}

// ❌ INCORRECTO
class Card extends StatelessWidget {
  final dynamic props; // Sin tipos
  @override
  Widget build(BuildContext context) => Text(props.a); // Lógica acoplada
}
```

#### Providers (Estado con Riverpod / Provider)
- [ ] Un provider por dominio
- [ ] Extraer lógica de negocio fuera del widget
- [ ] Manejar estados: loading, data, error
- [ ] Documentar dependencias

```dart
// ✅ CORRECTO
/// Provider para fincas del usuario actual
/// Sincroniza con WatermelonDB local y backend remoto
final farmsProvider = AsyncNotifierProvider<FarmsNotifier, List<Farm>>(
  FarmsNotifier.new,
);

class FarmsNotifier extends AsyncNotifier<List<Farm>> {
  @override
  Future<List<Farm>> build() async {
    return ref.read(farmServiceProvider).getMyFarms();
  }

  Future<void> addFarm(FarmInput input) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(farmServiceProvider).create(input),
    ).then((_) => build());
  }
}

// ❌ INCORRECTO
// Lógica de negocio dentro del widget — no testeable, no reutilizable
class FarmsScreen extends StatefulWidget {
  Future<void> _loadFarms() async {
    final response = await http.get(Uri.parse('/api/farms'));
    // ...
  }
}
```

---

## 🔐 SEGURIDAD

### Authentication
```typescript
// ✅ SIEMPRE usar JWT + refresh token pattern
const tokens = {
  accessToken: jwt.sign(payload, secret, { expiresIn: '15m' }),
  refreshToken: jwt.sign(payload, refreshSecret, { expiresIn: '7d' }),
};

// ❌ NUNCA usar sesiones sin HTTPS
// ❌ NUNCA guardar tokens en localStorage (móvil: usar Secure Storage)
// ❌ NUNCA exponer secretos en el cliente
```

### Password Hashing
```typescript
// ✅ CORRECTO
import bcrypt from 'bcrypt';

const hashedPassword = await bcrypt.hash(password, 10);
const isValid = await bcrypt.compare(password, hashedPassword);

// ❌ INCORRECTO
const hash = password.split('').reverse().join('');  // No es seguro
```

### Input Validation
```typescript
// ✅ CORRECTO
import { z } from 'zod';

const farmSchema = z.object({
  name: z.string().min(3).max(255),
  latitude: z.number().min(-90).max(90),
  longitude: z.number().min(-180).max(180),
});

// ❌ INCORRECTO
if (req.body.name && req.body.latitude) {
  // Validación incompleta
}
```

### SQL Injection Prevention
```typescript
// ✅ CORRECTO: Prepared statements
const farm = await db.query(
  'SELECT * FROM farms WHERE id = $1',
  [farmId]
);

// ❌ INCORRECTO: String concatenation
const farm = await db.query(
  `SELECT * FROM farms WHERE id = ${farmId}`
);
```

---

## 📝 DOCUMENTACIÓN

### JSDoc Comments
```typescript
/**
 * Calcula el score de sostenibilidad de un lote
 * 
 * @param {Plot} plot - El lote a evaluar
 * @param {Activity[]} activities - Actividades realizadas
 * @returns {number} Score de 0 a 100
 * 
 * @example
 * const score = calculateSustainabilityScore(plot, activities);
 * // Returns: 82
 * 
 * @throws {Error} Si el plot no tiene actividades
 */
export const calculateSustainabilityScore = (
  plot: Plot,
  activities: Activity[]
): number => {
  // Implementación
};
```

### README Mínimo
Todo repositorio o carpeta debe tener README.md con:
- Descripción
- Instalación
- Cómo ejecutar
- Variables de entorno
- Tests
- API docs (si aplica)

---

## 🧪 TESTING

### Jest Configuration
```javascript
// jest.config.js
module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  testMatch: ['**/__tests__/**/*.ts', '**/?(*.)+(spec|test).ts'],
  collectCoverageFrom: [
    'src/**/*.ts',
    '!src/**/*.d.ts',
  ],
  coverageThreshold: {
    global: {
      branches: 70,
      functions: 70,
      lines: 70,
    },
  },
};
```

### Test Structure
```typescript
// ✅ CORRECTO
describe('FarmService', () => {
  let farmService: FarmService;
  let mockDb: jest.Mocked<Database>;

  beforeEach(() => {
    mockDb = createMockDatabase();
    farmService = new FarmService(mockDb);
  });

  describe('create', () => {
    it('should create a farm with valid input', async () => {
      const input: FarmInput = {
        name: 'Test Farm',
        latitude: 3.5,
        longitude: -76.5,
      };

      const result = await farmService.create(input, 'producer-123');

      expect(result).toHaveProperty('id');
      expect(result.name).toBe('Test Farm');
    });

    it('should throw ValidationError if coordinates are invalid', async () => {
      const input = { name: 'Test', latitude: 200 };

      await expect(farmService.create(input, 'producer-123')).rejects.toThrow(
        ValidationError
      );
    });
  });
});

// ❌ INCORRECTO
it('should work', async () => {
  const result = await something();
  expect(result).toBeDefined();
});
```

---

## ❌ ANTI-PATTERNS

### 1. Callback Hell
```typescript
// ❌ INCORRECTO
getData((err, data) => {
  if (!err) {
    processData(data, (err, result) => {
      if (!err) {
        saveData(result, (err) => {
          if (!err) {
            console.log('Done');
          }
        });
      }
    });
  }
});

// ✅ CORRECTO
try {
  const data = await getData();
  const result = await processData(data);
  await saveData(result);
  console.log('Done');
} catch (err) {
  handleError(err);
}
```

### 2. God Classes
```typescript
// ❌ INCORRECTO
class UserService {
  // 500 líneas
  // Autenticación, validación, envío de emails, cálculos, etc.
}

// ✅ CORRECTO
class AuthService { }  // Solo autenticación
class UserService { }  // Solo gestión de usuarios
class EmailService { } // Solo envío de emails
```

### 3. Magic Numbers
```typescript
// ❌ INCORRECTO
if (farm.area > 100 && activity.daysAgo > 30) { }

// ✅ CORRECTO
const MAX_FARM_AREA = 100; // hectáreas
const STALE_ACTIVITY_DAYS = 30;

if (farm.area > MAX_FARM_AREA && activity.daysAgo > STALE_ACTIVITY_DAYS) { }
```

### 4. Console.log en Producción
```typescript
// ❌ INCORRECTO
console.log('User login:', user);  // ¡Exposición de datos!

// ✅ CORRECTO
logger.info('User login', { userId: user.id });  // Usar logger
```

### 5. Ignorar Errores
```typescript
// ❌ INCORRECTO
await saveFarm(farm).catch(() => {});  // ¿Qué pasó?

// ✅ CORRECTO
await saveFarm(farm).catch((err) => {
  logger.error('Failed to save farm', { error: err, farmId: farm.id });
  throw err;  // O manejar apropiadamente
});
```

---

## 🔄 VERSIONAMIENTO DE API

Usa versionamiento de URL:
```
/v1/farms       ← Versión 1
/v2/farms       ← Versión 2 (si hay breaking changes)
```

**Nunca hagas breaking changes sin versión nueva.**

---

## 📊 LOGGING

### Niveles de Log
```typescript
logger.debug('Detailed info for debugging');
logger.info('General informational message');
logger.warn('Warning, but app continues');
logger.error('Error that needs attention', { error: err });
logger.fatal('Critical error, app may stop');
```

### Qué Loguear
- ✅ Autenticación (login, logout)
- ✅ Errores
- ✅ Cambios de datos críticos
- ✅ Acciones administrativas
- ❌ Passwords
- ❌ Tokens
- ❌ Datos personales sensibles

---

## 📦 DEPENDENCIES

### Mantener Actualizado
```bash
npm outdated
npm update
npm audit fix
```

### Evitar Dependency Hell
- ✅ Usa monorepo si tienes múltiples packages
- ✅ Pin major versions
- ✅ Revisa vulnerabilidades
- ❌ No instales packages "porque sí"

---

## ✅ CHECKLIST PRE-COMMIT

Antes de hacer commit:
- [ ] Código pasa linting (`eslint`)
- [ ] Código pasa formatting (`prettier`)
- [ ] Tests pasan (`npm test`)
- [ ] TypeScript compila sin errores (`tsc --noEmit`)
- [ ] Sin console.log
- [ ] Sin credenciales en código
- [ ] Mensaje de commit es descriptivo

---

## 🚀 DEPLOYMENT

### Antes de ir a producción
- [ ] Tests cubriendo 70%+ de código
- [ ] Error handling en todos los endpoints
- [ ] Rate limiting habilitado
- [ ] CORS configurado
- [ ] Logging configurado
- [ ] Backups automáticos
- [ ] Monitoreo (Sentry, DataDog, etc.)
- [ ] Health check endpoint `/health`

---

## 📞 PREGUNTAS COMUNES

**P: ¿Dónde pongo lógica de negocio?**
R: En services, no en controllers ni en componentes.

**P: ¿Cuándo uso middleware vs guards?**
R: Middleware para cosas globales (autenticación, logging). Guards para rutas específicas.

**P: ¿Cómo manejar errores async?**
R: Siempre try-catch o .catch(), nunca ignorar promesas.

**P: ¿Debo usar ORM o raw SQL?**
R: Depende. ORM es más seguro, SQL es más rápido. Aquí usamos ORM (Prisma) para seguridad.

---

**Mantén esta guía actualizada** cuando descubras nuevos patrones o encuentres mejores prácticas.
