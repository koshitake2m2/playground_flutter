# sample_app コード規約

## 基本方針
- アーキテクチャはMVVMを採用する。
- UI層はView（Widget）とViewModelの1:1対応を守る。
- 依存性注入はRiverpodのProviderのみで行う。

## レイヤ責務
- **UI層**: `lib/ui/<feature>/` に配置し、描画とイベント通知のみを行う。
- **ViewModel**: UI状態を管理し、Repository経由でデータを取得・更新する。
- **Repository**: データの単一ソース。キャッシュ/リトライ/変換を担当する。
- **Service**: 外部API/プラグインの薄いラッパー。状態を持たない。
- **Domainモデル**: `lib/domain/models/` に配置し、UIはドメインモデルのみ扱う。

## 依存性注入（Riverpod）
- `ProviderScope` をアプリ起点に置く。
- ViewModel/Repository/ServiceはProviderで定義し、UIから直生成しない。
- テストでは`ProviderContainer`と`override`を使って依存を差し替える。

## 状態管理
- UI状態は不変（immutable）とし、必要に応じてFreezedで定義する。
- 状態更新はViewModel内で行い、Notifier/ChangeNotifierで通知する。
- UIは状態に従って描画するだけで、副作用はViewModelへ集約する。

## 命名・配置
- ファイル名は`lower_snake_case.dart`。
- クラス名は`PascalCase`。
- テストは`*_test.dart`で、`test/`配下に配置する。

## テスト
- ViewModelのユニットテストはFlutter依存を避ける。
- RepositoryのユニットテストはServiceをmock/fakeで差し替える。
- Widgetテストは実ViewModel + fake Repositoryで構築する。

## フォーマットと品質
- `dart format`で整形する。
- `analysis_options.yaml`のlintに従う。
- 新規ViewModel/Repository追加時は必ずテストを追加する。

## Active Technologies
- Dart >=3.10.4 / Flutter (SDK) + go_router ^17.0.1, riverpod/flutter_riverpod ^3.1.0, drift ^2.26.1, sqlite3 ^2.7.5 (001-demo-pages)
- Drift + SQLite（端末内） (001-demo-pages)

## Recent Changes
- 001-demo-pages: Added Dart >=3.10.4 / Flutter (SDK) + go_router ^17.0.1, riverpod/flutter_riverpod ^3.1.0, drift ^2.26.1, sqlite3 ^2.7.5
