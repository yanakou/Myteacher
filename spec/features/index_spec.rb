require 'rails_helper'

RSpec.describe "ユーザー一覧ページ", type: :feature do
  before do
    30.times{FactoryBot.create(:users)}
    @user = create(:user)
  end

  it "ユーザー一覧ページに、ページネーションが含まれていること" do
    visit login_path
    fill_in 'session[email]', with: 'user@example.com'
    fill_in 'session[password]', with: '000000'
    click_button 'ログイン'
    visit users_path
    expect(page).to have_css '.pagination'
  end
end