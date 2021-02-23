require 'rails_helper'

RSpec.describe "ログイン", type: :feature do
  before do
    @user = create(:user)
  end
  
  it "ログインする" do
    visit login_path
    fill_in 'session[email]', with: 'user@example.com'
    fill_in 'session[password]', with: '000000'
    click_button 'ログイン'
    expect(page).to have_no_link nil, href: login_path
    expect(page).to have_link nil, href: logout_path
    expect(page).to have_link nil, href: user_path(@user)
  end
end 
