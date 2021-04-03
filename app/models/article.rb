class Article < ApplicationRecord

  with_options presence: true do
    validates :title
    validates :text
    validates :category_id
  end

  has_many :articles
  #has_many :purchases
end
