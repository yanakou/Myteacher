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
    let(:tweet1){create(:tweet1)}

    it 'リクエストが成功すること' do
      get tweet_path(tweet1.id)
      expect(response.status).to eq 200
    end

    it 'title名が表示されていること' do
      get tweet_path(tweet1.id)
      expect(response.body).to include ("tweet1")
    end

    context 'tweetが存在しない場合' do
      subject { -> { get tweet_path 1} }

      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'GET #new' do
    context 'ログインしている場合' do
      before do
        user = create(:user)
        log_in_as(user)
      end

      it 'リクエストが成功すること' do
        get new_tweet_path
        expect(response.status).to eq 200
      end
    end

    context 'ログインしていない場合' do
      it 'リクエストは302 OKとなること' do
        get new_tweet_path
        expect(response.status).to eq 302
      end

      it 'ログイン画面にリダイレクトすること' do
        get new_tweet_path
        expect(response).to redirect_to login_url
      end
    end

  end

  describe 'GET #edit' do
    context 'ログインしている場合' do
      before do
        @tweet1 = create(:tweet1)
        @user2 = @tweet1.user
        log_in_as(@user2)
      end

      it 'リクエストが成功すること' do
        get edit_tweet_path(@tweet1.id)
        expect(response.status).to eq 200
      end

      it 'title名が表示されていること' do
        get edit_tweet_path(@tweet1.id)
        expect(response.body).to include 'tweet1'
      end

      it '本文が表示されていること' do
        get edit_tweet_path(@tweet1.id)
        expect(response.body).to include 'tweet1を投稿します'
      end
    end

    context 'ログインしていない場合' do
      it 'リクエストは302 OKとなること' do
        get new_tweet_path
        expect(response.status).to eq 302
      end

      it 'ログイン画面にリダイレクトすること' do
        get new_tweet_path
        expect(response).to redirect_to login_url
      end
    end
  end

  describe 'GET #create' do
    context 'ログインしている場合' do
      let(:user2){create(:user2)}

      before do
        log_in_as(user2)
      end

      context 'パラメータが妥当な場合' do
        it 'リクエストが成功すること' do
          post tweets_path, params: { tweet: FactoryBot.attributes_for(:tweet1) }
          expect(response.status).to eq 302
        end

        it '投稿が完了すること' do
          expect do
            post tweets_path, params: { tweet: FactoryBot.attributes_for(:tweet1) }
          end.to change(Tweet, :count).by(1)
        end

        it 'リダイレクトすること' do
          post tweets_path, params: { tweet: FactoryBot.attributes_for(:tweet1) }
          expect(response).to redirect_to root_url
        end
      end

      context 'パラメータが不正な場合' do
        it 'リクエストが成功すること' do
          post tweets_path, params: { tweet: FactoryBot.attributes_for(:tweet1, title: nil) }
          expect(response.status).to eq 200
        end
  
        it '投稿が完了しないこと' do
          expect do
            post tweets_path, params: { tweet: FactoryBot.attributes_for(:tweet1, title: nil) }
          end.to_not change(Tweet, :count)
        end
  
        it 'エラーが表示されること' do
          post tweets_path, params: { tweet: FactoryBot.attributes_for(:tweet1, title: "a"*41 ) }
          expect(response.body).to include 'Titleは40文字以内で入力してください'
        end
      end
    end

    context 'ログインしていない場合' do
      let(:user2){create(:user2)}

      it 'リクエストは302 OKとなること' do
        post tweets_path, params: { tweet: FactoryBot.attributes_for(:tweet1) }
        expect(response.status).to eq 302
      end

      it 'ログイン画面にリダイレクトすること' do
        post tweets_path, params: { tweet: FactoryBot.attributes_for(:tweet1) }
        expect(response).to redirect_to login_url
      end
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
