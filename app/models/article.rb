class Article < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  with_options presence: true do
    validates :title
    validates :text
    validates :category_id
  end

  belongs_to :category
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many_attached :images
end
