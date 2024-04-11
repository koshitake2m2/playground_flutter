# articles_app

A new Flutter project.

## setup

```bash
cd setup_sqljs
zsh setup.sh
```

## sql.js

1. web/ に [sql-js/sql.js](https://github.com/sql-js/sql.js/releases) の `sql-wasm.js` と `sql-wasm.wasm` を置く
  - https://github.com/sql-js/sql.js/releases/download/v1.10.2/sqljs-wasm.zip
  - or `pnpm i sql.js` でインストールして `node_modules/sql.js/dist/sql-wasm.js` と `node_modules/sql.js/dist/sql-wasm.wasm` をコピー
2. web/index.htmlに以下を追記

```html
<script src="sql-wasm.js"></script>
```

## tips

- webのsqlはlocalstorageに保存されている。
- vscodeの `Debug: Start Debugging` で実行するとホットリロードができる

