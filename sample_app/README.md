# sample_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## e2e tests

### integration_test

```bash
flutter test integration_test/login_test.dart --device-id $device_id --verbose
```

### maestro

```bash
# run
flutter run -d $device_id --debug

# or install
flutter build ios --simulator --debug
flutter install -d $device_id --debug
# xcrun simctl install $device_id build/ios/iphonesimulator/Runner.app

maestro test maestro/login.yaml --device $device_id
```

### patrol

```bash
patrol test -t patrol_test/patrol_login_test.dart -d $device_id --verbose
```
