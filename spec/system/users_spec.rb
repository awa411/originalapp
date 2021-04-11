require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  
  context "ユーザー登録に成功する" do
    it "ニックネーム、メールアドレス、パスワードを正しく入力すると、登録に成功する" do
      #トップページに移動する
      visit root_path
      #ユーザー新規登録画面へ遷移するリンクが表示されている
      expect(page).to have_content("新規登録")
      #ユーザー新規登録画面へ移動する
      visit new_user_registration_path
      #各入力フォームに値を入力する
      fill_in :user_nickname,              with: @user.nickname
      fill_in :user_email,                 with: @user.email
      fill_in :user_password,              with: @user.password
      fill_in :user_password_confirmation, with: @user.password_confirmation
      #送信ボタンを押下するとUserモデルのカウントが１上がる
      expect{
        find('input[name="commit"]').click
      }.to change{User.count}.by(1)
      #トップページに遷移する
      expect(current_path).to eq(root_path)
      #ログアウトをするリンクが表示される
      expect(page).to have_content("ログアウト")
      #新規登録およびログインをするリンクが表示されていない
      expect(page).to have_no_content("新規登録")
      expect(page).to have_no_content("ログイン")
    end
  end
  context "ユーザー登録に失敗する" do
    it "ニックネーム、メールアドレス、パスワードの入力に誤りがあると登録に失敗する" do
      #トップページに移動する
      visit root_path
      #ユーザー新規登録画面へ遷移するリンクが表示されている
      expect(page).to have_content("新規登録")
      #ユーザー新規登録画面へ移動する
      visit new_user_registration_path
      #各入力フォームに誤りの値を入力する
      fill_in :user_nickname,              with: ""
      fill_in :user_email,                 with: ""
      fill_in :user_password,              with: ""
      fill_in :user_password_confirmation, with: ""
      #送信ボタンを押下してもユーザーモデルがカウントされない
      expect{
        find('input[name="commit"]').click
      }.to change{User.count}.by(0)
      #ユーザー新規登録画面に戻る
      expect(current_path).to eq user_registration_path
    end
  end
end
