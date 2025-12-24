# Repository Guidelines

## Project Structure & Module Organization
- Single Android app module in `app/` with sources under `app/src/main/java/com/yechaoa/wanandroid_jetpack/`.
- Feature packages: `ui/` (screens/fragments), `data/` (network, room, models), `base/` (shared MVVM base classes), `common/` (config), `util/` (helpers).
- Resources live in `app/src/main/res/` (layouts, drawables, values). Tests are in `app/src/test/` (unit) and `app/src/androidTest/` (instrumented).
- Build configuration is in `build.gradle.kts`, `app/build.gradle.kts`, `gradle/`, and `buildSrc/`. Screenshots are in `screenshot/`.

## Build, Test, and Development Commands
- `./gradlew assembleDebug` builds a debug APK.
- `./gradlew installDebug` installs the debug build on a connected device or emulator.
- `./gradlew assembleRelease` builds a release APK (requires signing config in `jks/keystore.properties`).
- `./gradlew testDebugUnitTest` runs local unit tests.
- `./gradlew connectedDebugAndroidTest` runs instrumented tests on a device/emulator.
- `./gradlew lintDebug` runs Android Lint on the debug variant.

## Coding Style & Naming Conventions
- Kotlin (JVM 17) with 4-space indentation; use Android Studio formatting defaults.
- Classes/objects: `PascalCase`; functions/vars: `camelCase`; constants: `UPPER_SNAKE_CASE`.
- Resource names in `lower_snake_case` (e.g., `fragment_home.xml`, `ic_nav_back.xml`).
- Keep MVVM boundaries: UI logic in `ui/`, data access in `data/`, shared abstractions in `base/`.

## Testing Guidelines
- Unit tests use JUnit in `app/src/test/` (name classes `*Test.kt`).
- Instrumented tests use AndroidX/JUnit/Espresso in `app/src/androidTest/` (e.g., `*InstrumentedTest.kt`).
- Aim to cover ViewModel logic and data transformations; keep UI tests focused on key flows.

## Commit & Pull Request Guidelines
- Follow the existing commit style: `type: short description` (e.g., `feat: add search history`, `style: fix warnings`).
- PRs should describe scope, key changes, and testing done; include screenshots or screen recordings for UI changes.

## Security & Configuration Tips
- `local.properties` stores the SDK path; do not commit machine-specific values.
- Release signing reads `jks/keystore.properties` and the keystore file; keep secrets out of version control.
