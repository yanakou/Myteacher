# [MyTeacher](https://myteacher-support.com/)
https://myteacher-support.com/

ゲストユーザーとしてログインすることができます。

# アプリ概要
就職活動用のポートフォリオとして開発した個人アプリです。
何か目標に向けて頑張る人と、その人たちを応援したい人が繋がることができるアプリです。

- ユーザー登録することで記事を投稿・編集・削除できる
- 投稿に対していいね、コメントができる機能を実装
- ユーザー間のコミュニケーションを促すために、フォロー・通知・ダイレクトメッセージ機能を実装

# 機能一覧
- ユーザー機能
- 管理者権限
- 記事機能
- タグ付け機能
- コメント機能(Ajax)
- いいね機能(Ajax)
- フォロー機能(Ajax)
- ページネーション機能
- 検索機能
- ダイレクトメッセージ機能(Ajax)
- 通知機能
- 活動履歴の保存機能
- テスト機能

# 使用技術等
* フロントエンド：HTML JavaScript（jQuery）
* バックエンド：Ruby（Ruby on Rails）
    * テスト：RSpec
    * 静的コード解析：Rubocop
* データベース：MySQL
* インフラ：AWS（VPC | ALB | EC2 | S3 | Route53 | ACM）
* ソースコード管理：GitHub
* Webサーバ：Nginx
* アプリケーションサーバ：Unicorn
* 開発環境：Docker　Nginx、Rails、MySQLコンテナを用意して、docker-composeで起動します。
* 自動デプロイツール：Capistrano  githubのmasterブランチをデプロイ

# アプリのポイント
- **RSpecを使用して、テストコード数が200件以上あります**
- **N+1問題を意識したパフォーマンス**
- **主要機能をajaxで実装（いいね、フォロー、ダイレクトメッセージ、コメント機能）**
- 静的解析ツールRubocopを導入してコードの品質を担保
- 管理者機能を導入して本番運用を意識
- タグ入力時に自動補完機能を導入
- 完全に独学で開発
- 直感的に分かるデザイン
- 開発環境でDockerを採用することでスムーズにチーム開発が可能

# 工夫した点
## N+1問題を解決し、スムーズな処理を実現
投稿一覧画面の表示する際、N+1問題によって読み込みに3秒以上かかっていました。そこで、**includeメソッドを導入した結果1秒以下に短縮し、ストレスを感じる事がなくなりました。**
この技術はバックエンドエンジニアが現場でずっと意識しなければいけない問題だと考えているので、今回のアプリ制作では良い経験となりました。
## 多くの機能でAjaxを使用
いいね機能・フォロー機能・コメント機能・ダイレクトメッセージ機能をAjaxで実装することで、瞬時に表示が切り替わり、ストレスフリーなサービスを実現しました。

# 苦労した点
## RSpecを用いたテスト
これまでテストを書くことに慣れていなかったことと、アソシエーションが多かったことから、初めは苦労しました。しかし、今後バックエンドエンジニアとして現場でテストを書くことは品質を担保するために必要不可欠なので、できるだけしっかり書くことを意識し、**200以上のテストを行いました。**

# 機能詳細
## ユーザー機能
  - 新規登録、ログイン、ログアウト、編集機能
  - かんたんログイン機能
  - 管理者ユーザー機能
  - ユーザーの一覧表示
  
## 管理者権限
  - 権限を持ったユーザーは、不快な記事やコメントを削除できる

## 記事機能
  - 記事一覧表示、記事詳細表示、記事投稿、記事編集、記事削除機能
  - 画像のアップロードはcarrierwaveというgemを使用

## ページネーション機能
  - kaminariというgemを使用

## タグ付け機能
  - acts_as_taggableというgemと、jQueryプラグインのtag-itを使用
  - 記事に複数のタグをつけられる機能
  - タグ名は自由に入力可能
  - 入力時に自動補完機能付き（gonというgemを使用）

## コメント機能（ajax）
  - 記事ごとのコメント表示、コメント投稿、コメント編集、コメント削除機能

## いいね機能（ajax）
  - 記事にいいねした人の一覧表示
  - ユーザーがいいねした記事の一覧表示
  - 人気順表示機能

## フォロー機能（ajax）
  - フォロー、フォロワー一覧表示機能
  - タイムライン機能

## 検索機能
  - 投稿記事の内容を検索
  - タイトルと本文の曖昧検索

## ダイレクトメッセージ機能(ajax)
  - 1：1のチャットルームを作成
  - メッセージ送信、メッセージ削除機能

## 通知機能
  - いいね、コメント、フォロー、ダイレクトメッセージを受信したら通知
  - 未読通知があるとお知らせを表示

## 活動履歴の保存機能
  - いいね、コメント、フォロー、ダイレクトメッセージを送信した履歴を確認可能

## テスト機能
  - RSpecを使用（テスト件数は200以上）

# 使用した主なgem
* kaminari ：ページネーション機能
* carrierwave：画像投稿
* act-as-taggalbe-on：タグ機能
* gon：タグ入力時の自動補完機能
* rspec-rails ：テストコード
* factory_bot_rails ：テストデータ作成
* faker ：ダミーデータ作成

# インフラ構成図
![インフラ構成図 ver2](https://user-images.githubusercontent.com/63568678/135774522-6d1e4a9c-016c-4c84-a205-7dddbfd423dc.png)

# DB設計
<img width="1241" alt="データベース設計" src="https://user-images.githubusercontent.com/63568678/135774163-b6b45989-1a83-4353-9891-195b7f4f88b4.png">