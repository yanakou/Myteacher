require 'rails_helper'

RSpec.describe "UsersSignup", type: :request do
  describe "GET /signup" do
    it "invalid signup information" do
      get signup_path
      expect do
        post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
      end.to_not change{User.count}
      expect(response).to render_template("users/new")
    end
  end
end
