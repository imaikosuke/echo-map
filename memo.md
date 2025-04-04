# EchoMap 開発ドキュメント

## プロジェクト概要

**EchoMap** は、位置情報と音声を組み合わせた「音声タイムカプセル」アプリです。ユーザーは特定の場所で音声メッセージを録音し、他のユーザーがその場所を訪れた（録音地点の半径Nメートル以内）際にメッセージを聞くことができます。時間と空間を超えた思い出の共有を目指します。

## ディレクトリ構成

```
.
├── public
│   ├── images
│   │   ├── marker-icon.png
│   │   └── marker-shadow.png
│   ├── icons (PWA用アイコン置き場予定)
│   └── (その他SVGファイル)
├── src
│   ├── app
│   │   ├── layout.tsx (共通レイアウト)
│   │   ├── globals.css
│   │   ├── page.tsx (トップページ)
│   │   └── map
│   │       ├── page.tsx (マップ表示ページ)
│   │       ├── Map.tsx (マップコンポーネント)
│   │       └── marker-icon.ts (Leafletのマーカー設定)
│   └── lib
│       └── utils.ts (共通ユーティリティ)
├── next.config.ts
├── eslint.config.mjs
├── postcss.config.mjs
├── tailwind.config.ts
├── package.json
├── pnpm-lock.yaml
└── tsconfig.json
```

## 技術スタック

### フロントエンド

- Next.js 15.2.4 (App Router)
- TypeScript 5
- TailwindCSS 4.1.2
- shadcn/ui (class-variance-authority, tailwind-merge, clsx)
- Lucide-react (アイコン)
- ESLint + Prettier + Secretlint

### バックエンド

- Supabase (Auth, Database, Storage, PostGIS)

### 地図表示

- leaflet 1.9.4 + react-leaflet 5.0.0

### 音声録音 & 再生（導入予定）

- Web Audio API + MediaRecorder API
- wavesurfer.js (波形の視覚化予定)

### PWA対応（導入予定）

- next-pwa + Web Manifest (Next.js公式方式)

### デプロイ

- Vercel

## データベース設計（Supabase）

### テーブル: `audio_posts`

| カラム名   | 型                    | 説明                                 |
| ---------- | --------------------- | ------------------------------------ |
| id         | UUID                  | 投稿のユニークID                     |
| user_id    | UUID                  | 投稿者のユーザーID (Supabase Auth)   |
| latitude   | FLOAT                 | 緯度                                 |
| longitude  | FLOAT                 | 経度                                 |
| geom       | geometry(Point, 4326) | 位置情報のポイントデータ (PostGIS用) |
| audio_url  | TEXT                  | Supabase Storage の音声URL           |
| created_at | TIMESTAMP             | 投稿日時                             |

### テーブル: `users`

| カラム名   | 型        | 説明       |
| ---------- | --------- | ---------- |
| id         | UUID      | ユーザーID |
| name       | TEXT      | ユーザー名 |
| created_at | TIMESTAMP | 作成日時   |

## 優先すべきタスク（MVP）

1. **ユーザー認証**（Supabase Authを利用したログイン・サインアップ機能）
2. **音声録音 & 再生**
   - Web Audio APIとMediaRecorder APIを使った録音と再生機能
   - wavesurfer.jsを利用した音声波形の視覚化
   - ブラウザ互換性を考慮した録音フォーマット (audio/webm等)
3. **位置情報取得 & マップ表示**
   - Geolocation APIによる位置情報取得
   - leaflet, react-leafletを使用した地図表示・現在位置表示
   - Supabase（PostGIS）を用いて現在地近辺の投稿を効率的に取得
4. **投稿データの保存 & 取得**
   - Supabase Storageへの音声データの保存
   - 投稿データをSupabase Database（PostGIS対応）に保存・クエリ最適化

## PWA対応に関する設計（Next.js公式方式）

- **Web Manifest (`src/app/manifest.ts`)**
- **Service Worker (`public/sw.js`, next-pwaを使った設定予定)**

## コマンド（npm scripts）

```bash
pnpm dev              # 開発サーバ起動 (Turbopack有効)
pnpm build            # ビルド
pnpm start            # 本番用サーバ起動
pnpm lint             # ESLintの実行
pnpm lint-fix         # ESLint自動修正
pnpm prettier         # コード整形 (Prettier)
pnpm prettier-check   # コード整形チェック
pnpm secretlint       # シークレット情報の検知
```

## 追加アイデア（余裕があれば）

- 投稿の公開範囲設定（友達限定、全体公開）
- いいね機能
- Webプッシュ通知（web-push + Supabase DBに通知登録管理）

## 備考

- Node.jsバージョン: 22.14.0
- パッケージマネージャー: pnpm@10.6.3

## まとめ

EchoMap は最新のNext.jsとSupabaseを活用し、短期間でMVPを完成させることを目指します。継続的にドキュメントを更新し、環境構築や技術スタックの変更点を明確に管理していきます。
