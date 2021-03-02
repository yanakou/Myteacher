require 'rails_helper'

RSpec.describe "Users", type: :request do

  before do
    @user = create(:user)
    @other_user = create(:user2)
  end

  describe "GET /signup" do
    it "ログインページの表示に成功すること" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /users/:id/edit" do
    context "非ログイン時" do
      it "編集ページにアクセスすると、ログインページにリダイレクトすること" do
        get edit_user_path(@user)
        expect(flash).to_not be_empty
        expect(response).to redirect_to login_url
      end
    end

    context "異なるユーザーでログインを試みた場合" do
      it "編集ページにアクセスすると、ルートurlにリダイレクトすること" do
        log_in_as(@other_user)
        get edit_user_path(@user)
        expect(flash).to be_empty
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "PATCH /users/:id" do
    context "非ログイン時" do
      it "編集を試みると、ログインページにリダイレクトすること" do
        patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
        expect(flash).to_not be_empty
        expect(response).to redirect_to login_url
      end
    end

    context "異なるユーザーでログインを試みた場合" do
      it "編集を試みると、ルートurlにリダイレクトすること" do
        log_in_as(@other_user)
        patch user_path(@user), params: { user: { name: @user.name,
                                                  email: @user.email } }
        expect(flash).to_not be_empty
        expect(response).to redirect_to login_url
      end
    end
  end

end
