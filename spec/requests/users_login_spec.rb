require 'rails_helper'

RSpec.describe "UsersLogin", type: :request do

  before do
    @user = create(:user)
  end

  it "有効なユーザーでログイン後、ログアウトする" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: '000000' } }
    expect(is_logged_in?).to be_truthy
    expect(response).to redirect_to @user
    follow_redirect!
    expect(response).to render_template("users/show")
    delete logout_path
    expect(is_logged_in?).to be_falsey
    expect(response).to redirect_to root_url
  end

  it "有効なアドレスと無効なパスワードでログイン失敗する" do
    get login_path
    expect(response).to render_template("sessions/new")
    post login_path, params: { session: { email: "user@example.com", password: "invalid" } }
    expect(is_logged_in?).to be_falsey
    expect(response).to render_template("sessions/new")
    expect(flash).not_to be_empty
    get root_path
    expect(flash).to be_empty
  end

  it "無効なアドレスとパスワードでログイン失敗する" do
    get login_path
    expect(response).to render_template("sessions/new")
    post login_path, params: { session: { email: "", password: "" } }
    expect(response).to render_template("sessions/new")
    expect(flash).not_to be_empty
    get root_path
    expect(flash).to be_empty
  end
end