require 'rails_helper'

RSpec.describe "Articles", type: :system do
  before do
    @article = FactoryBot.build(:article)
    @user = FactoryBot.build(:user)
  end
  
  context "記事の新規投稿に成功する" do
    it "画像、タイトル、カテゴリ、本文を正しく入力すると新規投稿に成功する" do
      #トップページに遷移する
      visit root_path
      #ログインする
      sign_in(@user)
      #新規投稿画面へ遷移するリンクが表示されている
      expect(page).to have_content("投稿")
      #新規投稿画面へ移動する
      visit new_article_path
      #添付する画像を定義する
      image_path = Rails.root.join("app/assets/images/cherry-blossom-6068004_1920.jpg")
      #フォームに正しい値を入力する
      attach_file("article[image]", image_path)
      select "グルメ", from: "article_category_id"
      fill_in :article_title, with: @article.title
      fill_in :article_text, with: @article.text
      #投稿ボタンを押下するとArticleモデルのカウントが１上がる
      expect{
        find('input.new-article-post').click}.to change{Article.count}.by(1)
      #トップページに遷移する
      expect(current_path).to eq(root_path)
      #投稿された記事が表示されている
      expect(page).to have_selector("img")
    end
  end
  context "記事の新規投稿に失敗する" do
    it "フォームが空だと新規投稿に失敗する" do
      #トップページに遷移する
      visit root_path
      #ログインする
      sign_in(@user)
      #新規投稿画面へ遷移するリンクが表示されている
      expect(page).to have_content("投稿")
      #新規投稿画面へ移動する
      visit new_article_path
      #フォームに誤りの値を入力する
      select "指定なし", from: "article_category_id"
      fill_in :article_title, with: ""
      fill_in :article_text, with: ""
      #投稿ボタンを押下するとArticleモデルのカウントが上がらない
      expect{
        find('input.new-article-post').click}.to change{Article.count}.by(0)
      #新規投稿画面に戻る
      expect(current_path).to eq(articles_path)
    end
  end
end
