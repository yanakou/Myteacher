class TweetsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]



  def index
    @tweets = Tweet.all.page(params[:page]).per(10)
    @tweets = @tweets.tagged_with(params[:tag_name].to_s) if params[:tag_name]
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
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user).order('created_at asc')
  end

  def destroy
  end

  private
  
  def tweet_params
    params.require(:tweet).permit(:title, :text, :image, :tag_list)
  end
end
