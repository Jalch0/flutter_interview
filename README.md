# Flutter Interview - Países de Europa 🇪🇺

Aplicación Flutter que consume la [API REST Countries](https://restcountries.com/): lista de países de Europa, detalle por país con caché inteligente y lista de deseos persistida en Drift. Desarrollada con Clean Architecture, BLoC y pruebas unitarias.

## ✨ Funcionalidad

- **Lista de países**: Cards con bandera, nombre, capital, región y población; pull-to-refresh.
- **Detalle**: Pantalla con datos ampliados (idiomas, monedas, husos horarios). Caché por país (una petición por país, reutilización posterior).
- **Lista de deseos**: Añadir/quitar países; persistencia local con Drift; página dedicada para ver y eliminar.
- **Rendimiento**: Operación costosa simulada al guardar en favoritos; ejecutada en **Isolate** para evitar janks en la UI.

## 🏗️ Arquitectura

Estructura por **features** y **core** compartido:

```
lib/
├── main.dart
├── src/
│   ├── core/                    # Infraestructura y contratos
│   │   ├── di/                  # GetIt: registro de dependencias
│   │   ├── error/               # Failure (Server, Database)
│   │   ├── network/             # Dio + dio_cache_interceptor
│   │   ├── usecases/            # Contrato UseCase<Type, Params>
│   │   └── widgets/             # CustomFlagImage (caché + memCache)
│   └── features/
│       ├── countries/           # API, entidades, BLoC lista + detalle
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       └── wishlist/            # Drift, DAO, BLoC, página
│           ├── data/
│           ├── domain/
│           └── presentation/
```

### Patrones y decisiones

- **Repository + UseCase**: Capa de datos abstraída; dominio con `Either<Failure, T>` (dartz). Excepciones de API (`RestCountriesException`) no salen del data layer.
- **BLoC + freezed**: Eventos y estados inmutables; lógica en use cases, no en el BLoC.
- **Caché por petición**: En el datasource de países, políticas distintas: lista con `maxStale: 24h`; detalle con `CachePolicy.forceCache`, `maxStale: 7 días` y `keyBuilder` normalizado por nombre (clave estable, una entrada por país).
- **GetIt**: Singletons para Dio, DB, repositorios y use cases; **factory** para los BLoCs (instancia nueva por pantalla cuando aplica).
- **Isolate**: La “operación pesada” al añadir a favoritos es inyectable (`WishlistHeavySimulation`); por defecto corre en `Isolate.run()` para no bloquear el hilo de UI.

### Imágenes

Las banderas son URLs devueltas por la API. La capa de datos no descarga imágenes; **CustomFlagImage** (core) usa `CachedNetworkImage` con `memCacheWidth`/`memCacheHeight` para limitar memoria en listas largas y placeholder/errorWidget. Separación clara: datos en data, carga y caché en presentación.

## 🛠️ Stack

| Área        | Tecnología                    |
|------------|-------------------------------|
| HTTP y caché | Dio, dio_cache_interceptor, dio_cache_interceptor_db_store |
| Estado     | flutter_bloc, freezed         |
| Base local | Drift (path_provider)         |
| DI         | get_it                        |
| Tests      | mocktail, bloc_test           |
| Código     | dartz (Either), json_serializable, flutter_lints |

## 🚀 Cómo ejecutar

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## 🧪 Tests

```bash
flutter test
```

- **BLoC**: `CountryListBloc`, `CountryDetailBloc`, `WishlistBloc` — casos de éxito y error (fetch, load, add, remove).
- **Acceso a datos**: `WishlistRepositoryImpl` (éxito y `SqliteException` → `DatabaseFailure` en save/get/remove); `WishlistDao` con Drift en memoria (insert, getAll, delete).

Los tests usan mocks de use cases y del data source; el BLoC y la lógica de repositorio quedan cubiertos.

## API utilizada

- **Base**: `https://restcountries.com/v3.1`
- **Lista Europa**: `GET /region/europe`
- **Detalle por nombre**: `GET /name/{name}?fullText=true` (caché configurada en el datasource como se indicó arriba).

## 📄 Información adicional

Proyecto de prueba técnica. Ver `pubspec.yaml` para dependencias y versiones.

---

Desarrollado con Flutter y Clean Architecture.
