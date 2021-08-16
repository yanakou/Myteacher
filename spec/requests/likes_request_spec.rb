require 'rails_helper'

RSpec.describe "Likes", type: :request do
  describe 'POST #create' do
    before do
      @tweet = create(:tweet)
      @user = @tweet.user
      log_in_as(@user)
    end

    it 'リクエストが成功すること' do
      post tweet_likes_path(@tweet.id), xhr: true
      expect(response.status).to eq 200
    end

    it 'いいねが追加されること' do
      expect do
        post tweet_likes_path(@tweet.id), xhr: true
      end.to change(Like, :count).by(1)
    end
  end

  describe 'DELETE #destroy' do
  end
end
