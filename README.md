# Aurelia Planner

A Flutter planner for organizing daily tasks and schedules. It includes a Today dashboard, task list, schedule, focus mode, daily goal, and selectable themes in a responsive dark interface. Planner data and preferences are stored locally on the device with `shared_preferences`.

## Requirements

- Flutter SDK compatible with the Dart constraint in `pubspec.yaml`

## Run

```sh
flutter pub get
flutter run
```

To run the web build:

```sh
flutter run -d chrome
```

## Project structure

- `lib/app/` — app setup and theme
- `lib/pages/` — Today, Tasks, Schedule, and Settings screens
- `lib/widgets/` — reusable interface components
- `lib/models/` — task, schedule, and theme models
- `lib/data/` — starter planner data and local persistence
- `test/` — Flutter widget tests

Platform-specific project files are included for Android, iOS, and web. Generated build output, local SDK configuration, editor settings, and logs are excluded through `.gitignore` files.
