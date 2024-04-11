#!/bin/sh
pnpm i --frozen-lockfile && \
  cp node_modules/sql.js/dist/sql-wasm.js ../web && \
  cp node_modules/sql.js/dist/sql-wasm.wasm ../web;
 