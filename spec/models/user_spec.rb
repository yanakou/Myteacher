require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(
      name:"Example User", 
      email:"user@example.com")
  end

  it "name、emailがある場合、有効である" do
    expect(@user).to be_valid
  end
  
  it "nameがない場合、無効である" do
    @user.name = ""
    expect(@user).not_to be_valid
  end

  it "emailがない場合、無効である" do
    @user.email = ""
    expect(@user).not_to be_valid
  end

  it "nameが51文字以上の場合、無効である" do
    @user.name = "a"*51
    expect(@user).not_to be_valid
  end

  it "emailが255文字以上の場合、無効である" do
    @user.email = "a"*244 + "@example.com"
    expect(@user).not_to be_valid
  end

  it "emailのフォーマットが正しい場合、有効である" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org 
      first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      expect(@user).to be_valid, "#{valid_address.inspect} should be valid"
    end
  end

end
