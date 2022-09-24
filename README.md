# Catch up Ruby on Rails
## 手順
- Dockerコンテナ上にRailsの開発環境を作成
- Railsをはじめようのチュートリアルを実施
- Rubyの記法やRailsの特色、関連ツールの概要を掴む

## ref.
- [20分ではじめるRuby](https://www.ruby-lang.org/ja/documentation/quickstart/)
- [PHPからRubyへ](https://www.ruby-lang.org/ja/documentation/ruby-from-other-languages/to-ruby-from-php/)
- [Railsをはじめよう](https://railsguides.jp/getting_started.html)
- [Rails テスティングガイド](https://railsguides.jp/testing.html)
- [クィックスタート: Compose と Rails](https://docs.docker.jp/compose/rails.html)
- [Running Rails' system tests with Docker](https://nicolasiensen.github.io/2022-03-11-running-rails-system-tests-with-docker/)

## 開発メモ
### Docker
```
# 起動しているコンテナの確認
$ docker ps

# コンテナに入る
$ docker exec -it CONTAINER_ID COMMAND [ARG...]
$ docker exec -it 563e648ce374 /bin/bash
```

### Docker Compose

```
# プロジェクトビルド
$ docker-compose run web rails new . --force --database=postgresql
$ docker-compose run サービス [コマンド] [引数...]

# Dockerイメージビルド
$ docker-compose build

# アプリ起動
$ docker-compose up
```

### Rails

```
# プロジェクトビルド
$ bin/rails new .

# コントローラー生成
$ bin/rails generate controller Articles index --skip-routes # config/routes.rbにルーティングを記述した場合は--skip-routesでルーティングの追加をスキップできる

# モデル生成
$ bin/rails generate model Article title:string body:text

# DB生成
$ bin/rake db:create

# DBマイグレーション - アップ
$ bin/rails db:migrate # サーバで直接実行する場合
$ docker-compose run --rm web rails db:migrate # Docker経由の場合

# DBマイグレーション - ダウン
$ bin/rails db:migrate:down VERSION=20220923160052

# ルーティング一覧
$ bin/rails routes
...


# テスティング
$ bin/rails test test/models/article_test.rb

# テスティング - システムテスト
$ bin/rails test:system
```
