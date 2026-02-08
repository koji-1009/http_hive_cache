## 1.0.1

* Added API documentation for `HttpHiveCache`, `CacheStrategy`, `HttpHiveResponse`, and related classes.

## 1.0.0

* **Breaking Change**: Migrated from `hive` to `hive_ce` (Community Edition) v2.
* **Breaking Change**: Replaced `freezed` classes with Dart 3 `sealed class` for `CacheStrategy`.
* **Breaking Change**: `HttpHiveCache.open()` now creates/opens the box internally. Removed `init()`.
* **New**: Added `path` parameter to `open()` for better cache directory usage.
* **New**: Added `prefix` parameter to `open()` for safe key namespacing.
* **New**: Added `typeId` parameter to `open()` to prevent Adapter conflicts.
* **New**: Switched to `LazyBox` for optimized memory usage with large caches.
* **New**: Improved `CacheStrategy` API for better readability.
  * `CacheStrategy.client(cacheControl: Duration)`
  * `CacheStrategy.server()`
  * `CacheStrategy.none()`
* **Refactor**: Removed dependencies on `path_provider` (now optional in app), `build_runner`, `hive_generator`.

## 0.0.4

* http v1.0.0

## 0.0.3

* Change type_id.

## 0.0.2

* Update.

## 0.0.1

* initial release.
