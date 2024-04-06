# playground_flutter

## setup

### brew install

```bash
brew install --cask flutter
brew tap dart-lang/dart
brew install dart
```

### Android
- sdk
  - API 33
- avd
  - Pixel 4
  - arm64-v8a

## Setup

```bash
gem install xcodeproj --user-install
fvm releases
fvm install 3.13.4
fvm use 3.13.4
fvm list
# プロジェクト作成
mkdir <your_project>
cd <your_project>
fvm use 3.13.4 --force
fvm flutter create .
# firebase
flutterfire configure --account=<your email> --project=pocket-money-record-book
```

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

## デバッグ

- emulatorの選択
  - vscode で > Flutter: Select Device

1. vscode で Run > Start Debugging

もしくは

```bash
fvm flutter run -d web-server --web-hostname=localhost --web-port=5000
```

### sqlite

```bash
cd ~/Library/Android/sdk/platform-tools
./adb shell

cd /data/data/com.example.articles_app/
sqlite3 app_flutter/db.sqlite
```


## reference
- [Flutter - Build apps for any screen](https://flutter.dev/)
  - [Cookbook | Flutter](https://docs.flutter.dev/cookbook)
- [Flutter実践入門](https://zenn.dev/kazutxt/books/flutter_practice_introduction)
- Android Setup
  - [m1 macでAndroid Emulatorを起動させる](https://zenn.dev/tatsuhiko/articles/0cf97aa4a238ae)

