class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|

      t.timestamps
      t.string     :title,       null: false
      t.text       :text,        null: false
      t.integer    :category_id, null: false
      t.references :user,        foreign_key: true
    end
  end
end
