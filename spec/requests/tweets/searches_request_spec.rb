require 'rails_helper'

RSpec.describe "Tweets::Searches", type: :request do
  describe "GET /index" do
    let!(:tweet1){create(:tweet1)}
    context '検索内容がヒットする場合' do
      it 'リクエストが成功すること' do
        get tweets_searches_path, params: { keyword: 'tweet1' }
        expect(response.status).to eq 200
      end

      it 'titleが表示されていること' do
        get tweets_searches_path, params: { keyword: 'tweet1' }
        expect(response.body).to include ("tweet1")
      end
    end

    context '検索内容がヒットしない場合' do
      it 'リクエストが成功すること' do
        get tweets_searches_path, params: { keyword: 'tweet2' }
        expect(response.status).to eq 200
      end

      it '検索内容不一致の結果が表示されていること' do
        get tweets_searches_path, params: { keyword: 'tweet2' }
        expect(response.body).to include ("一致する投稿はありません")
      end
    end
  end
end
