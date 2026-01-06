# 実装計画: デモページ一覧とTodo CRUD

**ブランチ**: `001-demo-pages` | **日付**: 2026-01-06 | **Spec**: specs/001-demo-pages/spec.md
**ブランチ作成**: 不要（必要時のみ）
**入力**: `/specs/001-demo-pages/spec.md` の仕様

**注記**: このテンプレートは `/speckit.plan` コマンドで生成される前提です。出力は日本語で記述してください。

## 概要

ホーム画面にデモページの一覧を用意し、TODO CRUDの挙動確認ページと状態保持ナビゲーションの検証ページへ遷移できるようにする。TODOは端末内に保存され、追加/編集/削除が即時に一覧へ反映されることを確認する。状態保持ページではセクション切替後も各セクションの状態が維持されることを示す。

## 技術コンテキスト

**言語/バージョン**: Dart >=3.10.4 / Flutter (SDK)  
**主要依存**: go_router ^17.0.1, riverpod/flutter_riverpod ^3.1.0, drift ^2.26.1, sqlite3 ^2.7.5  
**ストレージ**: Drift + SQLite（端末内）  
**テスト**: flutter_test, test, mocktail  
**対象プラットフォーム**: iOS/Android（Flutter）  
**プロジェクト種別**: mobile  
**性能目標**: 60fpsを維持し、CRUD操作の反映は3秒以内  
**制約**: TodoRecordsはtitleのみ、ローカル保存のみ、3ページ（ホーム/TODO/状態保持）に限定  
**規模/スコープ**: 3ページ、単一CRUD機能、検証用UI

## Constitution Check

*GATE: Phase 0の前に必須。Phase 1設計後に再確認する。*

- [x] MVVM分離: ViewはViewModelのみ依存、ViewModelはRepositoryのみ依存
- [x] DI: 依存解決はRiverpod Providerに統一（直生成/シングルトン禁止）
- [x] UI状態は不変で、通知はViewModelから一方向
- [x] Repositoryが真実の源、Serviceは外部APIの薄いラッパー
- [x] ViewModel/Repository追加時のユニットテスト計画がある

**Phase 1 再確認**

- [x] MVVM分離: ViewはViewModelのみ依存、ViewModelはRepositoryのみ依存
- [x] DI: 依存解決はRiverpod Providerに統一（直生成/シングルトン禁止）
- [x] UI状態は不変で、通知はViewModelから一方向
- [x] Repositoryが真実の源、Serviceは外部APIの薄いラッパー
- [x] ViewModel/Repository追加時のユニットテスト計画がある

## プロジェクト構造

### ドキュメント（本機能）

```text
specs/001-demo-pages/
├── plan.md              # このファイル (/speckit.plan)
├── research.md          # Phase 0 出力
├── data-model.md        # Phase 1 出力
├── quickstart.md        # Phase 1 出力
├── contracts/           # Phase 1 出力
└── tasks.md             # Phase 2 出力 (/speckit.tasks)
```

### ソースコード（リポジトリルート）

```text
lib/
├── ui/
│   ├── core/
│   ├── home/
│   │   ├── view_models/
│   │   └── widgets/
│   ├── todo_crud/
│   │   ├── view_models/
│   │   └── widgets/
│   └── stateful_shell_route/
│       ├── view_models/
│       └── widgets/
├── data/
│   ├── repositories/
│   └── services/
├── domain/
│   └── models/
└── main.dart

test/
├── ui/
├── data/
└── domain/

testing/
└── fakes/
```

**構成判断**: UIは機能単位で分離し、データ層は型別に集約することでMVVMの責務分離を維持する。

## Complexity Tracking

> **Constitution Checkに違反がある場合のみ記入**

該当なし
