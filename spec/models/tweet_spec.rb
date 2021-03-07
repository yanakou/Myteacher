require 'rails_helper'

RSpec.describe Tweet, type: :model do

  context "tweetを保存できる場合" do
    it "投稿が有効であること" do
      @tweet = create(:tweet)
      expect(@tweet).to be_valid
    end

    it "imageがnilでもtweetを保存できること" do
      @tweet = create(:tweet, image: nil)
      expect(@tweet).to be_valid
    end
  end

  context "tweetを保存できない場合" do
    it "textとtitleの両方が空の場合は保存できない" do
      @tweet = build(:tweet, title: nil, text: nil)
      expect(@tweet).not_to be_valid
    end

    it "タイトルが空でないこと" do
      @tweet = build(:tweet, title: nil)
      expect(@tweet).not_to be_valid
    end

    it "タイトルが41文字以上の場合は保存できないこと" do
      @tweet = build(:tweet, title: Faker::Lorem.characters(number: 41))
      expect(@tweet).not_to be_valid
    end


    it "textが空でないこと" do
      @tweet = build(:tweet, text: nil)
      expect(@tweet).not_to be_valid
    end

    it "textが1501文字以上の場合は保存できないこと" do
      @tweet = build(:tweet, text: Faker::Lorem.characters(number: 1501))
      expect(@tweet).not_to be_valid
    end

    it "user_idtが空でないこと" do
      @tweet = build(:tweet, user_id: nil)
      expect(@tweet).not_to be_valid
    end
  end 
end
