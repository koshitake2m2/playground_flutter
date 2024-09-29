# playground_flutter

## Setup

```bash
brew install --cask flutter
brew tap dart-lang/dart
brew install dart
gem install xcodeproj --user-install
fvm releases
fvm install 3.13.4
fvm use 3.13.4
cd <your_project>
fvm use 3.13.4 --force
fvm flutter build macos
```

### Android
- sdk
  - API 33
- avd
  - Pixel 4
  - arm64-v8a


## migration

```bash
# コード生成
fvm flutter pub run build_runner build
fvm flutter gen-l10n

# コンフリクトがある場合
fvm flutter pub run build_runner build --delete-conflicting-outputs

# cachedがおかしいとき
fvm flutter clean

fvm flutter packages pub run build_runner build
```

## Run

```bash
fvm flutter run -d web-server --web-hostname=localhost --web-port=5000
```

