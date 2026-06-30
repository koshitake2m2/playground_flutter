---

description: "機能実装のタスク一覧"
---

# Tasks: デモページ一覧とTodo CRUD

**入力**: `/specs/001-demo-pages/` の設計ドキュメント
**前提**: plan.md（必須）、spec.md（必須）、research.md、data-model.md、contracts/

**テスト**: ViewModel/Repositoryを追加するため、ユニットテストを必須とする。

**構成**: タスクはユーザーストーリー単位でまとめ、独立実装・独立テストを可能にする。

## 形式: `[ID] [P?] [Story] 内容`

- **[P]**: 並行実行可能（別ファイル、依存なし）
- **[Story]**: 対応するユーザーストーリー（例: US1, US2, US3）
- タスク記述には具体的なファイルパスを含める

## パス規約

- Flutter単一アプリ: `lib/`, `test/`, `testing/` をルートに配置
- パスはplan.mdの構成に合わせる

## フェーズ1: セットアップ（共有基盤）

**目的**: 初期化と基本構造

- [x] T001 plan.mdの構成に従ってディレクトリを作成する（`lib/ui/home/`, `lib/ui/todo_crud/`, `lib/ui/stateful_shell_route/`, `lib/data/db/`, `lib/data/repositories/`, `lib/data/services/`, `lib/domain/models/`, `test/ui/`, `test/data/`, `testing/fakes/`）

---

## フェーズ2: 基盤（ブロッキング）

**目的**: すべてのストーリーに共通する基盤

**⚠️ CRITICAL**: ここが完了するまでストーリー実装を開始しない

- [x] T002 GoRouter設定を追加する（`lib/routing/app_router.dart`）
- [x] T003 RiverpodのProviderScopeとルーター接続を反映する（`lib/main.dart`）

**Checkpoint**: 基盤完了

---

## フェーズ3: ユーザーストーリー1 - デモページ一覧から遷移する (Priority: P1) 🎯 MVP

**目的**: ホーム画面から各デモページへ即時遷移できる入口を用意する

**独立テスト**: ホーム画面から「TODO CRUD」「StatefulShellRoute」ページへ遷移できる

### テスト（必須: ViewModel/Repository追加時）

> **NOTE: テストを先に書き、失敗することを確認してから実装**

- [x] T004 [P] [US1] DemoPage用fake serviceを作成する（`testing/fakes/fake_demo_page_service.dart`）
- [x] T005 [P] [US1] DemoPage用fake repositoryを作成する（`testing/fakes/fake_demo_page_repository.dart`）
- [x] T006 [P] [US1] HomeViewModelのユニットテストを追加する（`test/ui/home_view_model_test.dart`）
- [x] T007 [P] [US1] DemoPageRepositoryのユニットテストを追加する（`test/data/demo_page_repository_test.dart`）

### 実装

- [x] T008 [P] [US1] DemoPageモデルを追加する（`lib/domain/models/demo_page.dart`）
- [x] T009 [P] [US1] DemoPageServiceを実装する（`lib/data/services/demo_page_service.dart`）
- [x] T010 [US1] DemoPageRepositoryを実装する（`lib/data/repositories/demo_page_repository.dart`）
- [x] T011 [P] [US1] HomeViewModelを実装する（`lib/ui/home/view_models/home_view_model.dart`）
- [x] T012 [US1] HomeScreenを実装する（`lib/ui/home/widgets/home_screen.dart`）
- [x] T013 [US1] ホームルートを登録する（`lib/routing/app_router.dart`）

**Checkpoint**: US1が独立して動作・テスト可能

---

## フェーズ4: ユーザーストーリー2 - TODOを追加・編集・削除する (Priority: P1)

**目的**: TODO CRUDの挙動を確認できるページを提供する

**独立テスト**: TODOの追加/編集/削除が一覧に即時反映され、再起動後も保持される

### テスト（必須: ViewModel/Repository追加時）

- [x] T014 [P] [US2] TodoLocalService用fakeを作成する（`testing/fakes/fake_todo_local_service.dart`）
- [x] T015 [P] [US2] TodoRepository用fakeを作成する（`testing/fakes/fake_todo_repository.dart`）
- [x] T016 [P] [US2] TodoCrudViewModelのユニットテストを追加する（`test/ui/todo_crud_view_model_test.dart`）
- [x] T017 [P] [US2] TodoRepositoryのユニットテストを追加する（`test/data/todo_repository_test.dart`）

### 実装

- [x] T018 [P] [US2] Todoモデルを追加する（`lib/domain/models/todo.dart`）
- [x] T019 [P] [US2] Driftのテーブル定義を追加する（`lib/data/db/todo_tables.dart`）
- [x] T020 [US2] Driftデータベースを実装する（`lib/data/db/app_database.dart`）
- [x] T021 [US2] `flutter pub run build_runner build --delete-conflicting-outputs`を実行し、生成ファイルを確認する（`lib/data/db/app_database.g.dart`）
- [x] T022 [P] [US2] TodoLocalServiceを実装する（`lib/data/services/todo_local_service.dart`）
- [x] T023 [US2] TodoRepositoryを実装する（`lib/data/repositories/todo_repository.dart`）
- [x] T024 [P] [US2] TodoCrudViewModelを実装する（`lib/ui/todo_crud/view_models/todo_crud_view_model.dart`）
- [x] T025 [US2] TodoCrudScreenを実装する（`lib/ui/todo_crud/widgets/todo_crud_screen.dart`）
- [x] T026 [US2] TODOルートを登録する（`lib/routing/app_router.dart`）

**Checkpoint**: US1/US2が独立して動作・テスト可能

---

## フェーズ5: ユーザーストーリー3 - 状態保持の挙動を試す (Priority: P2)

**目的**: StatefulShellRouteで状態保持を検証できるページを提供する

**独立テスト**: セクション切替後にカウンタ値や入力状態が保持される

### テスト（必須: ViewModel/Repository追加時）

- [x] T027 [P] [US3] StatefulShellViewModelのユニットテストを追加する（`test/ui/stateful_shell_view_model_test.dart`）
- [x] T028 [P] [US3] サブViewModelのユニットテストを追加する（`test/ui/shell_counter_view_model_test.dart`, `test/ui/shell_notes_view_model_test.dart`）

### 実装

- [x] T029 [P] [US3] StatefulShell関連ViewModelを実装する（`lib/ui/stateful_shell_route/view_models/stateful_shell_view_model.dart`, `lib/ui/stateful_shell_route/view_models/shell_counter_view_model.dart`, `lib/ui/stateful_shell_route/view_models/shell_notes_view_model.dart`）
- [x] T030 [P] [US3] StatefulShellRoute用Widgetを実装する（`lib/ui/stateful_shell_route/widgets/stateful_shell_route_screen.dart`, `lib/ui/stateful_shell_route/widgets/shell_counter_screen.dart`, `lib/ui/stateful_shell_route/widgets/shell_notes_screen.dart`）
- [x] T031 [US3] StatefulShellRouteのルート定義を追加する（`lib/routing/app_router.dart`）

**Checkpoint**: 全ストーリーが独立して動作・テスト可能

---

## フェーズN: 仕上げ（横断対応）

**目的**: 複数ストーリーに影響する改善

- [x] T032 [P] quickstartの検証と必要な修正を行う（`specs/001-demo-pages/quickstart.md`）
- [x] T033 [P] ドキュメントの最終チェックを行う（`specs/001-demo-pages/spec.md`, `specs/001-demo-pages/plan.md`）

---

## 依存関係と実行順

- **セットアップ** → **基盤** → **ユーザーストーリー** → **仕上げ**
- ユーザーストーリーは基盤完了後に並行可能
- 優先度: US1(P1) と US2(P1) を先行し、US3(P2) は後続または並行

## 並行実行例

### US1

- T004（fake service）とT005（fake repository）
- T006（HomeViewModelテスト）とT007（Repositoryテスト）
- T008（DemoPageモデル）とT009（DemoPageService）とT011（HomeViewModel）

### US2

- T014（fake service）とT015（fake repository）
- T016（ViewModelテスト）とT017（Repositoryテスト）
- T018（Todoモデル）とT019（Driftテーブル）とT022（Service）

### US3

- T027（ShellViewModelテスト）とT028（SubViewModelテスト）
- T029（ViewModel実装）とT030（Widget実装）

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
