require 'rails_helper'

RSpec.describe "Articles", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.build(:article)
    @article1 = FactoryBot.create(:article)
    @article1_edit = FactoryBot.build(:article)
    @article2 = FactoryBot.create(:article)
  end
  
  context "記事の新規投稿に成功" do
    it "画像、タイトル、カテゴリ、本文を正しく入力と新規投稿に成功" do
      #トップページに遷移
      visit root_path
      #ログイン
      sign_in(@user)
      #新規投稿画面へ遷移リンクが表示されている
      expect(page).to have_content("投稿")
      #新規投稿画面へ移動
      visit new_article_path
      #添付画像を定義
      image_path = Rails.root.join("app/assets/images/cherry-blossom-6068004_1920.jpg")
      #フォームに正しい値を入力
      attach_file("article[images][]", image_path)
      select "グルメ", from: "article_category_id"
      fill_in :article_title, with: @article.title
      fill_in :article_text, with: @article.text
      #投稿ボタンを押下とArticleモデルのカウントが１上がる
      expect{
        find('input.new-article-post').click}.to change{Article.count}.by(1)
      #トップページに遷移
      expect(current_path).to eq(root_path)
      #投稿された記事が表示されている
      expect(page).to have_selector("img")
    end
  end
  context "記事の新規投稿に失敗" do
    it "フォームが空だと新規投稿に失敗" do
      #トップページに遷移
      visit root_path
      #ログイン
      sign_in(@user)
      #新規投稿画面へ遷移リンクが表示されている
      expect(page).to have_content("投稿")
      #新規投稿画面へ移動
      visit new_article_path
      #フォームに誤りの値を入力
      select "カテゴリーを選択", from: "article_category_id"
      fill_in :article_title, with: ""
      fill_in :article_text, with: ""
      #投稿ボタンを押下とArticleモデルのカウントが上がらない
      expect{
        find('input.new-article-post').click}.to change{Article.count}.by(0)
      #新規投稿画面に戻る
      expect(current_path).to eq(articles_path)
    end
  end
  context "自分の記事の編集に成功" do
    it "画像、タイトル、カテゴリ、本文を正しく入力と記事の編集に成功" do
      # 記事1を投稿したユーザーでログイン
      sign_in(@article1.user)
      # 投稿記事一覧へ移動
      visit user_path(@article1.user)
      # 投稿記事に編集へのリンクがあることを確認
      # binding.pry
      expect(find("#article_#{@article1.id}")).to have_link '編集', href: edit_article_path(@article1)
      # 編集画面に移動
      visit edit_article_path(@article1)
      # 既に記事の内容が入力してある事を確認
      @article1.images.each do |image|
        expect(page).to have_selector ".exists_blob_image[src$='#{rails_blob_path(image)}']"
      end
      expect(find("#article_category_id").find("option[selected]").value.to_i).to eq(@article1.category_id)
      expect(find("#article_title").value).to eq(@article1.title)
      expect(find("#article_text").value).to eq(@article1.text)
      # 記事を編集
      find("#exists-blob-image_0").click
      image_path = Rails.root.join('app/assets/images/cherry-blossom-6068004_1920.jpg')
      attach_file('article[images][]', image_path, make_visible: true)
      select(value = "スポーツ", from: "article[category_id]")
      find("input[name='article[title]']").set(@article1_edit.title)
      find("textarea[name='article[text]']").set(@article1_edit.text)
      # 編集を完了してArticleのカウントが上がらない事を確認
      expect{find("input[name='commit']").click}.to change{Article.count}.by(0)
      # 記事詳細画面に遷移した事を確認
      sleep 2
      expect(current_path).to eq(article_path(@article1)) 
      # 変更した内容が反映されている事を確認
      expect(find(".show-article-title")).to have_content(@article1_edit.title)
      expect(find(".show-article-category")).to have_content("スポーツ")
      expect(find(".slick-slider").find("img")[:src]).to include("cherry-blossom-6068004_1920.jpg")
      expect(find(".show-article-text")).to have_content(@article1_edit.text)
    end
    it "画像、タイトル、カテゴリ、本文が空白だと記事の編集に失敗" do
      # 記事1を投稿したユーザーでログイン
      sign_in(@article1.user)
      # 投稿記事一覧へ移動
      visit user_path(@article1.user)
      # 投稿記事に編集へのリンクがあることを確認
      expect(find("#article_#{@article1.id}")).to have_link '編集', href: edit_article_path(@article1)
      # 編集画面に移動
      visit edit_article_path(@article1)
      # 既に記事の内容が入力してある事を確認
      @article1.images.each do |image|
        expect(page).to have_selector ".exists_blob_image[src$='#{rails_blob_path(image)}']"
      end
      expect(find("#article_category_id").find("option[selected]").value.to_i).to eq(@article1.category_id)
      expect(find("#article_title").value).to eq(@article1.title)
      expect(find("#article_text").value).to eq(@article1.text)
      # 記事を編集
      find("#exists-blob-image_0").click
      image_path = Rails.root.join('app/assets/images/cherry-blossom-6068004_1920.jpg')
      attach_file('article[images][]', image_path, make_visible: true)
      select(value = "カテゴリーを選択", from: "article[category_id]")
      find("input[name='article[title]']").set(nil)
      find("textarea[name='article[text]']").set(nil)
      # 編集を完了してArticleのカウントが上がらない事を確認
      expect{find("input[name='commit']").click}.to change{Article.count}.by(0)
      # 記事編集画面に戻ることを確認
      sleep 2
      expect(current_path).to eq(edit_article_path(@article1)) 
    end
  end
  context "記事を削除" do
    it "記事を削除" do
      # 記事1を投稿したユーザーでログイン
      sign_in(@article1.user)
      # 投稿記事一覧へ移動
      visit user_path(@article1.user)
      # 投稿記事に削除へのリンクがあることを確認
      expect(find("#article_#{@article1.id}")).to have_link '削除', href: article_path(@article1)
      # 削除をクリックし、Articleのカウントが1下がる事を確認
      expect{find(".user-article-destroy").click}.to change{Article.count}.by(-1)
      # ページが遷移しない事を確認
      expect(current_path).to eq(root_path)
      # 記事1が存在しない事を確認
      expect(page).to have_no_content(@article1)
    end
  end
end
