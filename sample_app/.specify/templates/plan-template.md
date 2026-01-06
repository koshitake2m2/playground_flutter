# 実装計画: [FEATURE]

**ブランチ**: `[###-feature-name]` | **日付**: [DATE] | **Spec**: [link]
**ブランチ作成**: 不要（必要時のみ）
**入力**: `/specs/[###-feature-name]/spec.md` の仕様

**注記**: このテンプレートは `/speckit.plan` コマンドで生成される前提です。出力は日本語で記述してください。

## 概要

[仕様からの要約: 主要要件 + 技術的アプローチ]

## 技術コンテキスト

<!--
  ACTION REQUIRED: このセクションはプロジェクト実態に合わせて具体化する。
  未確定項目は NEEDS CLARIFICATION を明記する。
-->

**言語/バージョン**: [例: Dart 3.x / Flutter 3.x または NEEDS CLARIFICATION]  
**主要依存**: [例: Riverpod, Freezed, GoRouter または NEEDS CLARIFICATION]  
**ストレージ**: [例: SQLite, SharedPreferences, Files または N/A]  
**テスト**: [例: flutter_test, mocktail または NEEDS CLARIFICATION]  
**対象プラットフォーム**: [例: iOS/Android または NEEDS CLARIFICATION]  
**プロジェクト種別**: [mobile]  
**性能目標**: [例: 60 fps, 起動<2s など]  
**制約**: [例: offline対応, <200ms p95 など]  
**規模/スコープ**: [例: 10画面, 3人月 など]

## Constitution Check

*GATE: Phase 0の前に必須。Phase 1設計後に再確認する。*

- [ ] MVVM分離: ViewはViewModelのみ依存、ViewModelはRepositoryのみ依存
- [ ] DI: 依存解決はRiverpod Providerに統一（直生成/シングルトン禁止）
- [ ] UI状態は不変で、通知はViewModelから一方向
- [ ] Repositoryが真実の源、Serviceは外部APIの薄いラッパー
- [ ] ViewModel/Repository追加時のユニットテスト計画がある

## プロジェクト構造

### ドキュメント（本機能）

```text
specs/[###-feature]/
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
│   └── <feature_name>/
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

**構成判断**: [上記構成の採用理由を簡潔に記述]

## Complexity Tracking

> **Constitution Checkに違反がある場合のみ記入**

| 違反内容 | 必要性 | 単純化案を却下した理由 |
|-----------|--------|------------------------|
| [例: レイヤ跨ぎの依存] | [現在の必要性] | [なぜ代替不可か] |
