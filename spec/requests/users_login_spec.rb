require 'rails_helper'

RSpec.describe "UsersLogin", type: :request do

  it "無効なユーザーでログインする" do
    get login_path
    expect(response).to render_template("sessions/new")
    post login_path, params: { session: { email: "", password: "" } }
    expect(response).to render_template("sessions/new")
    expect(flash).not_to be_empty
    get root_path
    expect(flash).to be_empty
  end
end