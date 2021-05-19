class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i

         validates :nickname, presence: true
         validates_format_of :password, with: PASSWORD_REGEX
         has_many :articles, dependent: :destroy
         has_many :bookmarks, dependent: :destroy

         has_many :bookmarks_articles, through: :bookmarks, source: :article

         def bookmark(article)
           bookmarks_articles << article
         end

         def unbookmark(article)
           bookmarks_articles.delete(article)
         end

         def bookmark?(article)
           bookmarks_articles.include?(article)
         end
end
