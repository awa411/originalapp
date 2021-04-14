# UserTable
| Column                  | Type    | Options                   |
| ----------------------- | ------- | ------------------------- |
| nickname                | string  | null:false                |
| email                   | string  | null:false, unique:true   |
| encrypted_password      | string  | null:false                |

### Association
has_many :articles


# ArticleTable
| Column                  | Type      | Options                   |
| ----------------------- | --------- | ------------------------- |
| title                   | string    | null:false                |
| text                    | string    | null:false                |
| category_id             | integer   | null:false                |
| user_id                 | references| foreign_key:true          |

### Association
be_longs :user
