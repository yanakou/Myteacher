require 'rails_helper'

RSpec.describe "UsersSignup", type: :request do
  describe "GET /signup" do
    let(:subject){User.create(name:  "",
                              email: "user@invalid",
                              password:              "foo",
                              password_confirmation: "bar" )}
    it "invalid signup information" do
      get signup_path
      expect{subject}.to_not change{User.count}
      expect(response).to render_template("users/new")
    end
  end
end
