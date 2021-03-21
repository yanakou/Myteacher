require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  before do
    @tweet = create(:tweet)
  end

  context "非ログイン時" do
    it "newアクション送信後、ログインページにリダイレクトすること" do
      get new_tweet_path
      expect(response).to redirect_to login_url
    end

    it "createアクション送信後、ログインページにリダイレクトすること" do
      expect do
        post tweets_path, params: { tweet: { title: "Lorem ipsum", text: "Hello! World!" } }
      end.not_to change{Tweet.count}
      expect(response).to redirect_to login_url
    end

    it "destroyアクション送信後、ログインページにリダイレクトされること" do
      expect do
        delete tweet_path(@tweet)
      end.not_to change{Tweet.count}
      expect(response).to redirect_to login_url
    end
  end
  
end
