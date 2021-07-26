require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  describe '#create' do
    context 'Userを保存できる場合' do
      it "nickname、email、passwordとpassword_confirmationが存在すれば登録できる" do
        expect(@user).to be_valid
      end

      it "avatarがnilの場合でも保存できる" do
        @user.avatar = nil
        expect(@user).to be_valid
      end

      it "nicknameが10文字以内なら保存できる" do
        @user.name = "あ" * 10
        expect(@user).to be_valid
      end

      it "passwordが6文字以上であれば登録できる" do
        @user.password = "1" * 6
        @user.password_confirmation = "1" * 6
        expect(@user).to be_valid
      end
    end

    
    context 'userが保存できない場合' do
      it "nameがない場合は登録できない" do
        @user.name = ""
        @user.valid?
        expect(@user.errors[:name]).to include("を入力してください")
      end

      it "emailがない場合は登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors[:email]).to include("を入力してください")
      end

      it "passwordがない場合は登録できない" do
        @user.password = @user.password_confirmation = ""
        expect(@user).not_to be_valid
      end

      it "passwordが存在してもpassword_confirmationがない場合は登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end

      it "nameが11文字以上であれば登録できない" do
        @user.name = "あ" * 11
        @user.valid?
        expect(@user.errors[:name]).to include("は10文字以内で入力してください")
      end

      it "重複したemailが存在する場合登録できない" do
        user = create(:user)
        another_user = build(:user, email: user.email)
        another_user.valid?
        expect(another_user.errors[:email]).to include("はすでに存在します")
      end

      it "passwordが5文字以下であれば登録できない" do
        @user.password = @user.password_confirmation = "a" * 5
        @user.valid?
        expect(@user.errors[:password]).to include("は6文字以上で入力してください")
      end
    end

    describe '一意性の検証' do
      it 'メールアドレスは大文字小文字を区別せず扱うこと' do
        @user = create(:user, email: 'user@example.com')
        another_user = build(:user, email: 'USER@EXAMPLE.COM')
        expect(another_user).not_to be_valid
        another_user.valid?
        expect(another_user.errors).to be_of_kind(:email, :taken)
      end
    end

    describe 'パスワードの検証' do
      it 'パスワードと確認用パスワードが間違っている場合、無効であること' do
        @user.password_confirmation = '0000'
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end
    end

    describe 'フォーマットの検証' do
      it "emailのフォーマットが正しい場合、有効である" do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org 
                            first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          @user.email = valid_address
          expect(@user).to be_valid, "#{valid_address.inspect} should be valid"
        end
      end
  
      it "emailのフォーマットが正しくない場合、無効である" do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. 
                            foo@bar_baz.com foo@bar+baz.com]
        invalid_addresses.each do |invalid_address|
          @user.email = invalid_address
          expect(@user).not_to be_valid, "#{invalid_address.inspect} should be invalid"
        end
      end
    end
  end
  describe '#delete' do
    it "ユーザーが削除されるとtweetも消えること" do
      @tweet = create(:tweet)
      expect do
        @tweet.user.destroy
      end.to change{Tweet.count}.by(-1)
    end
  end
end
