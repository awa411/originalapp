class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      
      t.references :user, foreign_key: true
      t.references :article, foreign_key: true
      t.timestamps
    end
    add_index :bookmarks, [:user_id, :article_id], unique: true
  end
end
