require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  describe 'GET #index' do
    before do
      tweet1 = create(:tweet1)
    end

    it 'リクエストが成功すること' do
      get root_path
      expect(response.status).to eq 200
    end

    it 'titleが表示されていること' do
      get tweets_path
      expect(response.body).to include ("tweet1")
    end
  end

  describe 'GET #show' do
    before do
      @tweet1 = create(:tweet1)
    end

    it 'リクエストが成功すること' do
      get tweet_path(@tweet1.id)
      expect(response.status).to eq 200
    end

    it 'title名が表示されていること' do
      get tweet_path(@tweet1.id)
      expect(response.body).to include ("tweet1")
    end

    context 'tweetが存在しない場合' do
      subject { -> { get tweet_path 1} }

      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  # context "非ログイン時" do
  #   it "newアクション送信後、ログインページにリダイレクトすること" do
  #     get new_tweet_path
  #     expect(response).to redirect_to login_url
  #   end

  #   it "createアクション送信後、ログインページにリダイレクトすること" do
  #     expect do
  #       post tweets_path, params: { tweet: { title: "Lorem ipsum", text: "Hello! World!" } }
  #     end.not_to change{Tweet.count}
  #     expect(response).to redirect_to login_url
  #   end

  #   it "destroyアクション送信後、ログインページにリダイレクトされること" do
  #     expect do
  #       delete tweet_path(@tweet)
  #     end.not_to change{Tweet.count}
  #     expect(response).to redirect_to login_url
  #   end
  # end
  
end
