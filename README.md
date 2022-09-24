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
- [Rails のシステム テストを Docker で実行する](https://nicolasiensen.github.io/2022-03-11-running-rails-system-tests-with-docker/)

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
      create  app/controllers/articles_controller.rb
      invoke  erb
      create    app/views/articles
      create    app/views/articles/index.html.erb
      invoke  test_unit
      create    test/controllers/articles_controller_test.rb
      invoke  helper
      create    app/helpers/articles_helper.rb
      invoke    test_unit

# モデル生成
$ bin/rails generate model Article title:string body:text
      invoke  active_record
      create    db/migrate/20220923122107_create_articles.rb
      create    app/models/article.rb
      invoke    test_unit
      create      test/models/article_test.rb
      create      test/fixtures/articles.yml

# DB生成
$ bin/rake db:create

# DBマイグレーション - アップ
$ bin/rails db:migrate # サーバで直接実行する場合
$ docker-compose run --rm web rails db:migrate # Docker経由の場合
Creating rails_catch-up_web_run ... done
== 20220923122107 CreateArticles: migrating ===================================
-- create_table(:articles)
   -> 0.2077s
== 20220923122107 CreateArticles: migrated (0.2078s) ==========================

# DBマイグレーション - ダウン
$ bin/rails db:migrate:down VERSION=20220923160052
== 20220923160052 CreateComments: reverting ===================================
-- drop_table(:comments)
   -> 0.0747s
== 20220923160052 CreateComments: reverted (0.1363s) ==========================


# ルーティング一覧
$ bin/rails routes
          Prefix Verb   URI Pattern                           Controller#Action
            root GET    /                                     articles#index
        articles GET    /articles(.:format)                   articles#index
                 POST   /articles(.:format)                   articles#create
     new_article GET    /articles/new(.:format)               articles#new
    edit_article GET    /articles/:id/edit(.:format)          articles#edit
         article GET    /articles/:id(.:format)               articles#show
                 PATCH  /articles/:id(.:format)               articles#update
                 PUT    /articles/:id(.:format)               articles#update
                 DELETE /articles/:id(.:format)               articles#destroy
...


# テスティング
$ bin/rails test test/models/article_test.rb

# テスティング - システムテスト
$ bin/rails test:system
```