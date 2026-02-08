# AI Agent Context

This document provides context for AI agents working on `http_hive_cache`.

## Project Overview

`http_hive_cache` is a Flutter/Dart library for caching HTTP GET requests using `hive_ce`. It is designed to be lightweight, simple, and dependency-light.

## Core Design Principles

1. **Simplicity First**: The public API should be minimal. `HttpHiveCache.open()` + `HttpHiveCache.get()` is the primary flow.
2. **Dependency Minimalist**: We removed `path_provider`, `build_runner`, `http` (direct dep), etc. to keep the package small.
   * `hive_ce` is the core storage engine.
   * `web` is used for web support.
   * `flutter` sdk is assumed.
3. **Modern Dart**: Use `sealed class`, `switch expressions`, and `records` where appropriate.
4. **Pluggable**: The HTTP client logic is abstracted. Users can inject their own client.
5. **Safe defaults**:
   * `typeId: 201` (configurable)
   * `prefix: 'http_hive_cache.'` (configurable)
   * `LazyBox` (memory safe)

## Architecture

* **`lib/http_hive_cache.dart`**: Main entry point. Exports public types.
* **`lib/src/http_hive_cache.dart`**: Core logic (Singleton-like static class). Manages Hive Box.
* **`lib/src/types.dart`**: Public data types (`HttpCache`, `HttpHiveResponse`, `CacheStrategy`).
* **`lib/src/http/`**: Platform abstraction for HTTP requests.
  * `http.dart`: `client` variable definition.
  * `native.dart`: `dart:io` implementation using `HttpClient`.
  * `web.dart`: `package:web` implementation using `fetch`.
  * `unsupported.dart`: Stub.

## Key Implementation Details

* **Adapter Registration**: Handled in `open()`. Includes logic to `override` adapter in Debug mode to handle Hot Restarts safely.
* **LazyBox**: We use `LazyBox` to load only keys into memory. `get()` fetches the heavy body payload.
* **Cache Strategy**: `sealed class CacheStrategy` controls validity.
  * `client`: TTL based on client config.
  * `server`: TTL based on `Cache-Control` header.

## Common Tasks

* **Adding Features**: Ensure zero-dependency bloat.
* **Debugging**: Remember `Hive` adapter issues with Hot Restart.
* **Web Support**: Ensure any new network logic works with `package:web`.
