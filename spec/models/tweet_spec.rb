require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe '#create' do
    context "tweetを保存できる場合" do
      it "投稿が可能である" do
        @tweet = create(:tweet)
        expect(@tweet).to be_valid
      end

      it "imageがnilでもtweetを保存できる" do
        @tweet = create(:tweet, image: nil)
        expect(@tweet).to be_valid
      end
    end

    context "tweetを保存できない場合" do
      it "textとtitleの両方が空の場合は保存できない" do
        @tweet = build(:tweet, title: nil, text: nil)
        expect(@tweet).not_to be_valid
      end

      it "タイトルが空の場合は保存できない" do
        @tweet = build(:tweet, title: nil)
        expect(@tweet).not_to be_valid
      end

      it "タイトルが41文字以上の場合は保存できない" do
        @tweet = build(:tweet, title: Faker::Lorem.characters(number: 41))
        expect(@tweet).not_to be_valid
      end


      it "textが空の場合は保存できない" do
        @tweet = build(:tweet, text: nil)
        expect(@tweet).not_to be_valid
      end

      it "textが1501文字以上の場合は保存できない" do
        @tweet = build(:tweet, text: Faker::Lorem.characters(number: 1501))
        expect(@tweet).not_to be_valid
      end

      it "user_idが空の場合は保存できない" do
        @tweet = build(:tweet, user_id: nil)
        expect(@tweet).not_to be_valid
      end
    end
  end
  
  describe "#search" do
    # 各テストの前にTweetを作成
    before do
      user = create(:user)
      @tweet = create(
        :tweet,
        title: "天気が良い",
        text: "今日は快晴です",
        user: user
      )

      @other_tweet = create(
        :tweet,
        title: "天気が悪い",
        text: "今日は雨です",
        user: user
      )
    end

    context "「晴」で検索した場合、曖昧検索できているか" do
      it "@tweetを返すこと" do
        expect(Tweet.search("晴")).to include(@tweet)
      end

      it "@other_tweetを返さないこと" do
        expect(Tweet.search("晴")).to_not include(@other_tweet)
      end
    end

    context "「快晴」で検索した場合、一致検索できているか" do
      it "@tweetを返すこと" do
        expect(Tweet.search("快晴")).to include(@tweet)
      end

      it "@other_tweetを返さないこと" do
        expect(Tweet.search("快晴")).to_not include(@other_tweet)
      end
    end

    context "検索に一致しないものは表示されないこと" do
      it "「曇り」で検索した場合、0件であること" do
        expect(Tweet.search("曇り")).to be_empty
      end
    end
  end
end
