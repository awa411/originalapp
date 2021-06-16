require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    @article = FactoryBot.build(:article)
  end

  describe "記事を投稿する" do
    context "投稿に成功する" do
      it "画像、タイトル、カテゴリ、本文が入力されている場合、投稿できる" do
        expect(@article).to be_valid
      end
    end
    context "投稿に失敗する" do
      it "タイトルが空の場合、投稿に失敗する" do
        @article.title = ""
        @article.valid?
        expect(@article.errors.full_messages).to include("Titleを入力してください")
      end
      it "カテゴリが空の場合、投稿に失敗する" do
        @article.category_id = nil
        @article.valid?
        expect(@article.errors.full_messages).to include("Categoryを入力してください")
      end
      it "本文が空の場合、投稿に失敗する" do
        @article.text = ""
        @article.valid?
        expect(@article.errors.full_messages).to include("Textを入力してください")
      end
    end
  end
end
