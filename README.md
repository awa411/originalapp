# Articles

[![Image from Gyazo](https://i.gyazo.com/abb697c6f6f32c6334bbb4d493e339c8.jpg)](https://gyazo.com/abb697c6f6f32c6334bbb4d493e339c8)


# <br>概要

## 「見やすさ」を第一に

シンプルで気軽に利用できる記事投稿サイト

# <br>URL
### https://originalapp-34872.herokuapp.com/

# <br>利用方法

#### トップページから「新規登録・ログイン」を押下
#### トップページへ遷移する
#### 「投稿」を押下
#### 投稿完了後はトップページへ遷移する

[![Image from Gyazo](https://i.gyazo.com/dbb17a35a9f181cf39258d0d0ec0ea96.gif)](https://gyazo.com/dbb17a35a9f181cf39258d0d0ec0ea96)

[![Image from Gyazo](https://i.gyazo.com/a2bef87ba988369f3eaf964ac55723a2.gif)](https://gyazo.com/a2bef87ba988369f3eaf964ac55723a2)

#### <br>記事一覧画面から投稿記事を選択 → 記事閲覧画面へ遷移する

[![Image from Gyazo](https://i.gyazo.com/9d2ff9bd015092aac158b04b1f7974de.gif)](https://gyazo.com/9d2ff9bd015092aac158b04b1f7974de)

#### <br>投稿者名をクリックすると、その投稿者の投稿記事一覧が表示される
#### 閲覧者が投稿者本人であれば投稿の編集・削除が可能になる

[![Image from Gyazo](https://i.gyazo.com/ea86d1c1e3c400bd1c6c7af1fa6ad2af.gif)](https://gyazo.com/ea86d1c1e3c400bd1c6c7af1fa6ad2af)
  
#### <br>他ユーザーの新規投稿記事をリアルタイム表示

![demo](https://gyazo.com/bc4def32606e4f2aa8e8b81b91f4396f.gif/raw)


# <br>課題解決
| 課題                                                        | 解決                                         |
| ------------------------------------------------------------------------------- | ------------------------------------------------- |
| 記事を閲覧する画面では記事の本文に集中したい    | 記事詳細画面ではサイドバーの表示を透明化にする |
| より詳細に記事を検索したい                   | キーワード検索に加え、カテゴリー指定を実装する |
| ページの更新をしなくても記事が新規投稿された事を知りたい | 新規投稿された記事をリアルタイムで表示する |   


# <br>要件定義
| 機能           | 概要             |
| -------------- | -----------------|
| ユーザー管理機能　| 新規登録・ログイン・ログアウトが可能  |
| 投稿機能 | 画像付きで記事投稿が可能 |
| 投稿詳細表示機能 | 各投稿記事の詳細が詳細ページで閲覧可能 |
| 投稿編集・削除機能 | 投稿者本人のみ投稿編集・削除が可能 |


# <br>追加予定機能

- ブックマーク機能
- イイね機能

# <br>ローカルでの動作方法

$ git clone https://github.com/awa411/originalapp.git
</br>
$ cd originalapp
</br>
$ bundle install
</br>
$ rails db:create
</br>
$ rails db:migrate
</br>
$ rails s
</br>
http://localhost:3000

# <br>開発環境

- VScode
- Ruby 2.6.5
- Rails 6.0.3.6
- mysql2 0.4.4
- JavaScript
- gem 3.0.3
- heroku 7.52.0

# <br>データベース設計
### UserTable
| Column                  | Type    | Options                   |
| ----------------------- | ------- | ------------------------- |
| nickname                | string  | null:false                |
| email                   | string  | null:false, unique:true   |
| encrypted_password      | string  | null:false                |

#### <br>Association
has_many :articles


### <br>ArticleTable
| Column                  | Type      | Options                   |
| ----------------------- | --------- | ------------------------- |
| title                   | string    | null:false                |
| text                    | string    | null:false                |
| category_id             | integer   | null:false                |
| user_id                 | references| foreign_key:true          |

### <br>Association
be_longs :user
