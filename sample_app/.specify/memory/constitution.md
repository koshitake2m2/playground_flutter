<!--
Sync Impact Report
- Version change: template -> 1.0.0
- Modified principles: なし（初回策定）
- Added sections: コア原則、追加制約、開発ワークフロー、Governance
- Removed sections: なし
- Templates requiring updates:
  - ✅ .specify/templates/plan-template.md
  - ✅ .specify/templates/spec-template.md
  - ✅ .specify/templates/tasks-template.md
  - ✅ .specify/templates/checklist-template.md
  - ✅ .specify/templates/agent-file-template.md
- Follow-up TODOs: なし
-->
# sample_app Constitution

## Core Principles

### I. MVVM分離の厳守
- 各機能はViewとViewModelで構成し、1 View : 1 ViewModelを守る。
- ViewはUI状態の表示とイベント発火に限定し、データ層へ直接アクセスしない。
- ViewModelはRepositoryのみを依存先とし、ServiceやAPIへの直接呼び出しは禁止する。
理由: 責務分離を明確にし、UIとデータの変更を独立させて保守性を高めるため。

### II. RiverpodによるDI
- 依存性注入はRiverpodのProviderで一元管理し、生成とライフサイクルをProvider内で完結させる。
- グローバルシングルトンや`new`による直生成は禁止（テスト用のProvider overrideは例外）。
- UI層はProvider経由でViewModelを取得し、Repository/ServiceはUIに露出させない。
理由: 依存関係の可視化と差し替え容易性を確保し、テストを簡潔にするため。

### III. 不変UI状態と通知
- UI状態は不変データとして扱い、書き換えではなく新しいインスタンスで更新する。
- 状態更新はViewModel内で行い、Riverpod Notifier/ChangeNotifier等で通知する。
- UIは状態に対して単方向に反応し、副作用はViewModelに集約する。
理由: 状態の追跡性を高め、再現性のあるUI更新を実現するため。

### IV. データレイヤ単一情報源
- Repositoryはデータ種別ごとの単一の真実の源であり、更新はRepository内のみで行う。
- Serviceは外部API/プラグインの薄いラッパーで、状態を持たない。
- RepositoryはAPIモデルをドメインモデルへ変換し、UIはドメインモデルのみを扱う。
理由: データ整合性と変更耐性を確保し、UIと外部APIの結合を避けるため。

### V. テスト可能性優先
- ViewModelのユニットテストはFlutter依存を持たず、Repositoryはfake/mockで差し替える。
- RepositoryのユニットテストはServiceをmock/fakeで差し替える。
- 新規ViewModel/Repository追加時は対応するユニットテストを必須とする。
理由: 回帰を防止し、アーキテクチャの健全性を検証し続けるため。

## 追加制約
- ディレクトリは`lib/ui`（機能別）、`lib/domain`（モデル）、`lib/data`（repositories/services）を基本とする。
- `lib/ui/core`には共有UI（テーマ、共通ウィジェット）を配置する。
- `test/`は`lib/`の構造に合わせ、`testing/`にはfakes/mocksなど共通テスト資材を置く。
- spec-kitの成果物（spec/plan/tasks/checklist）は日本語で記述する。

## 開発ワークフロー
- 仕様は`spec.md` → `plan.md` → `tasks.md`の順で作成する。
- `plan.md`のConstitution Checkを通過するまで設計・実装を開始しない。
- レビューではMVVM分離、Riverpod DI、UI状態の不変性、Repository/Service分離、テスト追加を確認する。
- 例外が必要な場合は`plan.md`のComplexity Trackingに明記する。

## Governance
- 本憲章は他のガイドラインに優先する。
- 改訂はPRで提案し、憲章・テンプレート・AGENTS.mdの整合更新を必須とする。
- バージョンはSemVerで管理する（MAJOR: 原則の破壊的変更、MINOR: 原則/節の追加、PATCH: 文言修正）。
- すべてのPRで憲章適合性をレビューし、逸脱は明示的に承認する。

**Version**: 1.0.0 | **Ratified**: 2026-01-06 | **Last Amended**: 2026-01-06
