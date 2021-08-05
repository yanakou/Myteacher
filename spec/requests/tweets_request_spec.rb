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

  describe 'GET #new' do
    before do
      user = create(:user)
      log_in_as(user)
    end
    
    it 'リクエストが成功すること' do
      get new_tweet_path
      expect(response.status).to eq 200
    end
  end

  
  
end
