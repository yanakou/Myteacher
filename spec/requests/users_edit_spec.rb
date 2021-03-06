require 'rails_helper'

RSpec.describe "UsersEdit", type: :request do
  before do
    @user = create(:user)
  end

    it 'ユーザー編集画面の表示に成功すること' do
      log_in_as(@user)
      get edit_user_path(@user)
      expect(response).to have_http_status(200)
    end
 

    it '編集失敗後にusers/editビューを表示すること' do
      log_in_as(@user)
      get edit_user_path(@user)
      expect(response).to render_template("users/edit")
      patch user_path(@user), params: { user: { name:  "",
                                                email: "foo@invalid",
                                                password:              "foo",
                                                password_confirmation: "bar" } }

      expect(response).to render_template("users/edit")
    end

    it 'フレンドリーフォワーディングが機能し、ユーザー編集に成功すること' do
      get edit_user_path(@user)
      expect(session[:forwarding_url]).not_to eq edit_user_path(@user)
      log_in_as(@user)
      expect(session[:forwarding_url]).to be_nil
      expect(response).to redirect_to edit_user_url(@user)
      name  = "Foo Bar"
      email = "foo@bar.com"
      patch user_path(@user), params: { user: { name:  name,
                                                email: email,
                                                password:              "",
                                                password_confirmation: "" } }
      expect(flash).not_to be_empty
      expect(response).to redirect_to @user
      @user.reload
      expect(@user.name).to eq name
      expect(@user.email).to eq email
    end


end