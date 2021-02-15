require 'rails_helper'

RSpec.describe "UsersSignup", type: :request do
  describe "無効なユーザー登録" do
    it "ユーザー数は変わらない" do
      get signup_path
      expect do
      post users_path, params:{user: {name:  "",
                              email: "user@invalid",
                              password:              "foo",
                              password_confirmation: "bar" }}
      end.to_not change{User.count}
      expect(response).to render_template("users/new")
    end
  end

  describe "有効なユーザー登録" do
    it "ユーザー数が1増える" do
      get signup_path
      expect do
      post users_path, params:{user: {name:  "Example User",
                                      email: "user@example.com",
                                      password:              "password",
                                      password_confirmation: "password" }}
      end.to change{User.count}.by(1)
      follow_redirect!
      expect(response).to render_template("users/show")
    end
  end

  
end
