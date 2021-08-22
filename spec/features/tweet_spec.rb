require 'rails_helper'

feature 'tweet', type: :feature do
  let(:user) { create(:user) }

  it 'ユーザー情報が更新されていること' do
    # ログイン前には投稿ボタンがない
    visit root_path
    expect(page).to have_no_content("投稿")

    # ログイン処理
    visit login_path
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    find('input[value="ログインする"]').click
    expect(current_path).to eq user_path(user.id)
    visit root_path
    expect(page).to have_content("投稿")

    # 投稿処理
    expect do
      click_link("投稿")
      expect(current_path).to eq new_tweet_path
      fill_in 'tweet_title', with: "結合テスト"
      fill_in 'md-textarea', with: "結合テスト"
      find('input[type="submit"]').click
    end.to change(Tweet, :count).by(1)
  end
end
