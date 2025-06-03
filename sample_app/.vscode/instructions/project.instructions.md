---
applyTo: "**"
---

# Project Instructions

## Project Structure

```text
lib
├── core              # Core functionalities
│   ├── di            # Dependency Injection
│   ├── utils         # Utilities
│   └── routing       # Routing
├── features          # Feature modules
│   └── XXX
└── main.dart
```

## Dependency Injection

- We use `riverpod` for dependency injection in this project.
- We define `Provider` in `lib/core/di/di.dart`.

## Routing

- We use `go_router` for routing in this project.
- We define routing in `lib/routing/router.dart`.

