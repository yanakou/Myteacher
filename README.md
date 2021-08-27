# [MyTeacher](https://yana-portfolio.herokuapp.com/)

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
- コメント機能
- いいね機能
- フォロー機能
- ページネーション機能
- 検索機能
- ダイレクトメッセージ機能
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
* CI/CD：CircleCI 
    * CI：プルリク発行時にrubucopとRSpecが自動で実行されます。
    * CD：GitHubのマスターブランチにマージされた時のみcapistranoが実行して自動デプロイされます。