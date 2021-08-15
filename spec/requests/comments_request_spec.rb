require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let!(:user){create(:user)}
  before do
    log_in_as(user)
    @tweet = create(:tweet)
  end

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post tweet_comments_path(@tweet.id), xhr: true, params: { comment: FactoryBot.attributes_for(:comment1)}
        expect(response.status).to eq 200
      end

      it 'メッセージ送信が完了すること' do
        expect do
          post tweet_comments_path(@tweet.id), xhr: true, params: { comment: FactoryBot.attributes_for(:comment1)}
        end.to change(Comment, :count).by(1)
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post tweet_comments_path(@tweet.id), xhr: true, params: { comment: FactoryBot.attributes_for(:comment1, content: nil)}
        expect(response.status).to eq 200
      end

      it 'メッセージ送信が完了しないこと' do
        expect do
          post tweet_comments_path(@tweet.id), xhr: true, params: { comment: FactoryBot.attributes_for(:comment1, content: nil)}
        end.to_not change(Comment, :count)
      end
    end
  end

  describe 'GET #edit' do
    before do
      @comment = create(:comment)
      @tweet = @comment.tweet
    end

    it 'リクエストが成功すること' do
      get edit_tweet_comment_path(@tweet.id, @comment.id), xhr: true
      expect(response.status).to eq 200
    end

    it 'contentが表示されていること' do
      get edit_tweet_comment_path(@tweet.id, @comment.id), xhr: true
      expect(response.body).to include @comment.content
    end
  end
end
