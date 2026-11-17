# PeriodicQuest

PeriodicQuest is a Flutter app for learning the periodic table. In the Explore
screen, learners can discover groups such as metals, nonmetals, and noble gases
and open the element catalog.

## Flutter Setup Instructions

1. Install Flutter SDK from the official docs: [Flutter Install Guide](https://docs.flutter.dev/get-started/install)
2. Use a Flutter SDK with Dart 3.10.3 or newer in the Dart 3 series, as specified in [app/pubspec.yaml](app/pubspec.yaml). Verify setup:
   ```bash
   flutter doctor
   ```
3. Resolve any reported platform/toolchain issues before proceeding.

## Install Dependencies

From the repository root:

```bash
cd app
flutter pub get
```

## Run the App

From `app/`:

1. List available devices:
   ```bash
   flutter devices
   ```
2. Run app:
   ```bash
   flutter run
   ```

## Run Tests

From `app/`, run the unit and widget tests:

```bash
flutter test
```

Run static checks:

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze
```

## Folder Structure

- [app/lib/](app/lib/) contains the Flutter application.
- [app/test/](app/test/) contains the tests.
- [app/pubspec.yaml](app/pubspec.yaml) defines the dependencies and Dart version.
- [.github/workflows/ci.yml](.github/workflows/ci.yml) runs the checks from `app/`.

## Branch Strategy

- `main`: protected branch for stable, releasable code
- working branches:
  - `feature/<name>`
  - `fix/<name>`
  - `chore/<name>`

## Pull Request Workflow

1. Create or pick an issue first.
2. Create a branch from `main`.
3. Implement and validate changes locally (`format`, `analyze`, `test`).
4. Open a PR using the template and link the issue (`Closes #<number>`).
5. Merge after CI passes and required reviews are complete.

## Release / Deployment Overview

Release and store deployment process is not yet documented.

Placeholder plan:
- define versioning and release cadence
- document build/signing process per platform
- add release workflow automation when pipeline requirements are finalized
