# Flutter Interview — European Countries

[![Flutter](https://img.shields.io/badge/Flutter-3.27+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.6+-0175C2?logo=dart)](https://dart.dev)

Aplicación Flutter que consume la [REST Countries API](https://restcountries.com/). Incluye listado de países europeos, detalle con caché por país y lista de deseos persistida localmente. Desarrollada con **Clean Architecture**, **BLoC** y pruebas unitarias.

---

## Tabla de contenidos

- [Características](#-características)
- [Requisitos](#-requisitos)
- [Arquitectura](#-arquitectura)
- [Stack tecnológico](#-stack-tecnológico)
- [Instalación y ejecución](#-instalación-y-ejecución)
- [Tests](#-tests)
- [API](#-api)
- [Notas del proyecto](#-notas-del-proyecto)

---

## ✨ Características

| Funcionalidad | Descripción |
|---------------|-------------|
| **Lista de países** | Cards con bandera, nombre, capital, región y población. Pull-to-refresh. |
| **Detalle de país** | Pantalla con datos ampliados (idiomas, monedas, husos horarios). Caché por país: una petición por país y reutilización posterior. |
| **Lista de deseos** | Añadir y quitar países; persistencia local con Drift; página dedicada para ver y eliminar. |
| **Rendimiento** | Operación costosa simulada al guardar en favoritos; ejecutada en **Isolate** para evitar janks en la UI. |

---

## 📋 Requisitos

- **Flutter** ≥ 3.27
- **Dart** ≥ 3.6

---

## 🏗️ Arquitectura

Organización **feature-first** con capas de Clean Architecture:

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

### Patrones y decisiones técnicas

- **Repository + UseCase**: Capa de datos abstraída; dominio con `Either<Failure, T>` (dartz). Las excepciones de API (`RestCountriesException`) no salen del data layer.
- **BLoC + Freezed**: Eventos y estados inmutables; lógica en use cases, no en el BLoC.
- **Caché por petición**: En el datasource de países, políticas distintas: lista con `maxStale: 24h`; detalle con `CachePolicy.forceCache`, `maxStale: 7 días` y `keyBuilder` normalizado por nombre (clave estable, una entrada por país).
- **GetIt**: Singletons para Dio, DB, repositorios y use cases; **factory** para los BLoCs (instancia nueva por pantalla cuando aplica).
- **Isolate**: La operación pesada al añadir a favoritos es inyectable (`WishlistHeavySimulation`); por defecto se ejecuta en `Isolate.run()` para no bloquear el hilo de UI.

### Imágenes

Las banderas son URLs devueltas por la API. La capa de datos no descarga imágenes; **CustomFlagImage** (core) usa `CachedNetworkImage` con `memCacheWidth`/`memCacheHeight` para limitar el uso de memoria en listas largas, con placeholder y errorWidget. Separación clara: datos en data, carga y caché en presentación.

---

## 🛠️ Stack tecnológico

| Área | Tecnología |
|------|------------|
| HTTP y caché | Dio, dio_cache_interceptor, dio_cache_interceptor_db_store |
| Estado | flutter_bloc, freezed |
| Base local | Drift (path_provider) |
| Inyección de dependencias | get_it |
| Tests | mocktail, bloc_test |
| Código | dartz (Either), json_serializable, flutter_lints |

---

## 🚀 Instalación y ejecución

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

---

## 🧪 Tests

```bash
flutter test
```

**Cobertura principal:**

- **BLoC**: `CountryListBloc`, `CountryDetailBloc`, `WishlistBloc` — casos de **éxito** y **error** (fetch, load, add, remove).
- **Acceso a datos**: `WishlistRepositoryImpl` (éxito y `SqliteException` → `DatabaseFailure` en save/get/remove); `WishlistDao` con Drift en memoria (insert, getAll, delete).

Los tests utilizan mocks de use cases y del data source; el BLoC y la lógica de repositorio quedan cubiertos.

---

## 🌐 API

| Recurso | Endpoint |
|---------|----------|
| Base | `https://restcountries.com/v3.1` |
| Lista Europa | `GET /region/europe` |
| Detalle por nombre | `GET /name/{name}?fullText=true` (caché configurada en el datasource). |

---

## 📄 Notas del proyecto

Proyecto de prueba técnica. Dependencias y versiones: ver `pubspec.yaml`.

---

*Desarrollado con Flutter y Clean Architecture.*
