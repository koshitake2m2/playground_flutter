# データモデル: デモページ一覧とTodo CRUD

## Entities

### TodoRecord
- **概要**: TODOの1項目
- **フィールド**:
  - **title**: 文字列、必須
- **関係**: なし（単独エンティティ）

### DemoPage
- **概要**: ホーム画面の遷移先を表す項目
- **フィールド**:
  - **name**: 表示名
  - **route**: 遷移先識別子
- **関係**: なし（静的リスト）

## Validation Rules

- TodoRecord.title は空文字不可
- 長文入力はUIで適切にフィードバックする（表示/保存の可否を明示）

## State Transitions

- **TodoRecord**: 追加 → 更新 → 削除
- **DemoPage**: 静的定義のため状態遷移なし
