class TweetsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]



  def index
    @tweets = Tweet.all.page(params[:page]).per(10)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:success] = "投稿しました！"
      redirect_to root_url
    else
      render 'tweets/new'
    end
  end

  def show
  end

  def destroy
  end

  private
  
  def tweet_params
    params.require(:tweet).permit(:title, :text, :image)
  end
end
