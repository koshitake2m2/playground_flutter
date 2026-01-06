# 調査メモ: デモページ一覧とTodo CRUD

## Decision: ルーティングはgo_router + StatefulShellRoute
**Rationale**: 既存依存にgo_routerがあり、StatefulShellRouteはセクション切替時の状態保持を検証できる。ナビゲーション構成を明確に分離できる。  
**Alternatives considered**: Navigator 2.0の手動実装、auto_route

## Decision: TODO永続化はDrift + SQLite（ローカル）
**Rationale**: 要件が「端末内保持」であり、Driftは型安全なクエリとマイグレーションを提供する。  
**Alternatives considered**: sqflite単体、shared_preferences（構造化CRUDに不向き）

## Decision: ViewModelはRiverpod Providerで管理
**Rationale**: 憲章のDIルールに従い、依存解決とライフサイクルをProviderで統一できる。  
**Alternatives considered**: Providerパッケージ、Bloc

## Decision: UI状態は不変でViewModelから通知
**Rationale**: UI更新の再現性とテスト容易性を確保できる。  
**Alternatives considered**: 直接StatefulWidgetで状態を持つ

## Decision: テスト構成
**Rationale**: ViewModelはRepositoryをfakeで置き換えてユニットテスト、RepositoryはServiceをfakeで置換して検証する。  
**Alternatives considered**: Widgetテストのみで担保する（回帰検知が弱い）

## Decision: TODOデータモデル
**Rationale**: 要件に従いタイトルのみをユーザー入力として保持する。識別子は永続化層で内部的に管理する。  
**Alternatives considered**: タイトル以外に期限や完了フラグを追加（今回は対象外）
