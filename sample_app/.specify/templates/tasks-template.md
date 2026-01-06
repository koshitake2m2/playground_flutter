---

description: "機能実装のタスク一覧テンプレート"
---

# Tasks: [FEATURE NAME]

**入力**: `/specs/[###-feature-name]/` の設計ドキュメント
**前提**: plan.md（必須）、spec.md（必須）、research.md、data-model.md、contracts/

**テスト**: ViewModel/Repositoryを追加する場合はテストを必須とする。省略はspec.mdで明示。

**構成**: タスクはユーザーストーリー単位でまとめ、独立実装・独立テストを可能にする。

## 形式: `[ID] [P?] [Story] 内容`

- **[P]**: 並行実行可能（別ファイル、依存なし）
- **[Story]**: 対応するユーザーストーリー（例: US1, US2, US3）
- タスク記述には具体的なファイルパスを含める

## パス規約

- Flutter単一アプリ: `lib/`, `test/`, `testing/` をルートに配置
- パスはplan.mdの構成に合わせる

<!--
  ============================================================================
  IMPORTANT: 以下はサンプルであり、/speckit.tasks は実際のタスクに置換する。

  - spec.md のユーザーストーリー（優先度 P1, P2, P3...）
  - plan.md の要件
  - data-model.md のエンティティ
  - contracts/ のAPI仕様

  タスクはユーザーストーリー単位で整理し、独立実装・独立テストを可能にする。
  ============================================================================
-->

## フェーズ1: セットアップ（共有基盤）

**目的**: 初期化と基本構造

- [ ] T001 plan.mdの構成に従ってディレクトリを整理
- [ ] T002 [P] 依存関係の追加と設定（Riverpod/Freezed等）
- [ ] T003 [P] lint/formatの設定（analysis_options.yaml）

---

## フェーズ2: 基盤（ブロッキング）

**目的**: すべてのストーリーに共通する基盤

**⚠️ CRITICAL**: ここが完了するまでストーリー実装を開始しない

- [ ] T004 Repository/Serviceの基底構造を定義
- [ ] T005 [P] テスト用fakes/mocksの骨格を作成
- [ ] T006 エラーハンドリング/Result型など共通ユーティリティ整備

**Checkpoint**: 基盤完了

---

## フェーズ3: ユーザーストーリー1 - [Title] (Priority: P1) 🎯 MVP

**目的**: [このストーリーで提供する価値]

**独立テスト**: [単独での検証方法]

### テスト（必須: ViewModel/Repository追加時）

> **NOTE: テストを先に書き、失敗することを確認してから実装**

- [ ] T010 [P] [US1] ViewModelユニットテストを `test/ui/...` に追加
- [ ] T011 [P] [US1] Repositoryユニットテストを `test/data/...` に追加
- [ ] T012 [P] [US1] Widgetテストを `test/ui/...` に追加（必要時）

### 実装

- [ ] T013 [P] [US1] Domainモデルを `lib/domain/models/...` に追加
- [ ] T014 [P] [US1] Serviceを `lib/data/services/...` に追加
- [ ] T015 [US1] Repositoryを `lib/data/repositories/...` に追加
- [ ] T016 [US1] ViewModelを `lib/ui/<feature>/view_models/...` に追加
- [ ] T017 [US1] View（Widget）を `lib/ui/<feature>/widgets/...` に追加

**Checkpoint**: US1が独立して動作・テスト可能

---

## フェーズ4: ユーザーストーリー2 - [Title] (Priority: P2)

**目的**: [このストーリーで提供する価値]

**独立テスト**: [単独での検証方法]

### テスト（必須: ViewModel/Repository追加時）

- [ ] T018 [P] [US2] ViewModelユニットテスト
- [ ] T019 [P] [US2] Repositoryユニットテスト

### 実装

- [ ] T020 [P] [US2] Domainモデル追加
- [ ] T021 [US2] Repository/Service追加
- [ ] T022 [US2] ViewModel/Widget追加

**Checkpoint**: US1/US2が独立して動作・テスト可能

---

## フェーズ5: ユーザーストーリー3 - [Title] (Priority: P3)

**目的**: [このストーリーで提供する価値]

**独立テスト**: [単独での検証方法]

### テスト（必須: ViewModel/Repository追加時）

- [ ] T024 [P] [US3] ViewModelユニットテスト
- [ ] T025 [P] [US3] Repositoryユニットテスト

### 実装

- [ ] T026 [P] [US3] Domainモデル追加
- [ ] T027 [US3] Repository/Service追加
- [ ] T028 [US3] ViewModel/Widget追加

**Checkpoint**: 全ストーリーが独立して動作・テスト可能

---

## フェーズN: 仕上げ（横断対応）

**目的**: 複数ストーリーに影響する改善

- [ ] TXXX [P] ドキュメント更新（specs/）
- [ ] TXXX リファクタリング
- [ ] TXXX [P] 追加テスト（必要時）
- [ ] TXXX パフォーマンス改善
- [ ] TXXX quickstart.md検証

---

## 依存関係と実行順

- **セットアップ** → **基盤** → **ユーザーストーリー** → **仕上げ**
- ユーザーストーリーは基盤完了後に並行可能
- テストは実装前に作成し、失敗を確認する

## 実装戦略

### MVP優先（US1のみ）

1. セットアップ
2. 基盤
3. US1
4. **停止して検証**

### 段階的デリバリー

1. 基盤完了
2. US1 → 検証
3. US2 → 検証
4. US3 → 検証
