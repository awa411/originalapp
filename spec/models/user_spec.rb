require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    context "登録に成功する" do
      it "ニックネーム、メールアドレス、パスワードが正しく入力されていると登録に成功する" do
        expect(@user).to be_valid
      end
    end
    context "登録に失敗する" do
      it "ニックネームが空の場合、登録に失敗する" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nicknameを入力してください")
      end
      it "メールアドレスが空の場合、登録に失敗する" do  
        @user.email = " "
        @user.valid?
        expect(@user.errors.full_messages).to include("Emailを入力してください")
      end
      it "すでに登録されたメールアドレスを入力すると、登録に失敗する" do
        @user.save
        user = FactoryBot.build(:user)
        user.email = @user.email
        user.valid?
        expect(user.errors.full_messages).to include("Emailはすでに存在します")
      end
      it "@が含まれていないメールアドレスを入力すると、登録に失敗する" do
        @user.email = "testexmaple"
        @user.valid?
        expect(@user.errors.full_messages).to include("Emailは不正な値です")
      end
      it "パスワードが空の場合、登録に失敗する" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Passwordを入力してください")
      end
      it "パスワードが全角の場合、登録に失敗する" do
        @user.password = "１１１１１１t"
        @user.valid?
        expect(@user.errors.full_messages).to include("Passwordは不正な値です")
      end
      it "パスワードに数字が含まれない場合、登録に失敗する" do
        @user.password = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Passwordは不正な値です")
      end
      it "パスワードに英字が含まれない場合、登録に失敗する" do
        @user.password = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Passwordは不正な値です")
      end
      it "パスワードに英字が含まれない場合、登録に失敗する" do
        @user.password = "1111a"
        @user.valid?
        expect(@user.errors.full_messages).to include("Passwordは6文字以上で入力してください")
      end
      it "パスワードとパスワードの確認欄が一致しない場合、登録に失敗する" do
        @user.password = "111111a"
        @user.password_confirmation = "111111b"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmationとPasswordの入力が一致しません")
      end
    end
  end
end
