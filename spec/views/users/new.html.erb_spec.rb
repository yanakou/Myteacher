require 'rails_helper'

RSpec.describe "users/new.html.erb", type: :view do
  it "ニックネームが表示されている" do
    visit signup_path
    expect(page).to have_content "ニックネーム"
  end
end
