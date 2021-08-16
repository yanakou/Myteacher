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

    it 'コメントが表示されていること' do
      get edit_tweet_comment_path(@tweet.id, @comment.id), xhr: true
      expect(response.body).to include @comment.content
    end
  end

  describe 'PUT #update' do
    before do
      @comment = create(:comment)
      @tweet = @comment.tweet
    end
    
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        put tweet_comment_path(@tweet.id, @comment.id), xhr: true, params: { comment: {content: 'Hello!'}}
        expect(response.status).to eq 200
      end

      it 'コメントが更新されること' do
        put tweet_comment_path(@tweet.id, @comment.id), xhr: true, params: { comment: {content: 'Hello!'}}
        expect(response.body).to include 'Hello!'
      end
    end

    context 'パラメータが不正な場合' do
      it 'コメントが更新されないこと' do
        expect do
          put tweet_comment_path(@tweet.id, @comment.id), xhr: true, params: { comment: {content: nil}}
        end.to_not change(Comment.find(@comment.id), :content)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @comment = create(:comment)
      @tweet = @comment.tweet
    end

    it 'リクエストが成功すること' do
      delete tweet_comment_path(@tweet.id, @comment.id), xhr: true
      expect(response.status).to eq 200
    end

    it 'コメントが削除されること' do
      expect do
        delete tweet_comment_path(@tweet.id, @comment.id), xhr: true
      end.to change(Comment, :count).by(-1)
    end
  end
end
