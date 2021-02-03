require 'rails_helper'

RSpec.describe User, type: :model do
 it "名前、メールアドレスがある場合、有効である" do
  user = User.new(
    name:"Example User", 
    email:"user@example.com"
  )

  expect(user).to be_valid
  end
end
