require 'rails_helper'

RSpec.describe "ユーザー一覧ページ", type: :feature do
  before do
    @admin = create(:user, name: 'example', email: 'user@example.com')
    @non_admin = create(:user2)
    30.times{FactoryBot.create(:users)}
  end

  context "管理者としてログイン" do
    it "ユーザー一覧ページに、ページネーションが含まれていること" do
      visit login_path
      fill_in 'session[email]', with: 'user@example.com'
      fill_in 'session[password]', with: '000000'
      click_button 'ログインする'
      visit users_path
      expect(page).to have_css '.pagination'
      first_page_of_users = User.all.page(1)
      first_page_of_users.each do |user|
        expect(page).to have_link user.name, href: user_path(user)
        unless user == @admin
        expect(page).to have_link '削除', href: user_path(user)
        end
      end
      expect do
        click_link '削除', href: user_path(@non_admin)
      end.to change{User.count}.by(-1)
    end
  end

  context "非管理者としてログイン" do
    it "ユーザー一覧ページに削除リンクが表示されないこと" do
      visit login_path
      fill_in 'session[email]', with: 'user2@example.com'
      fill_in 'session[password]', with: '000000'
      click_button 'ログイン'
      visit users_path
      expect(page).to have_link '削除', count:0
    end
  end


end