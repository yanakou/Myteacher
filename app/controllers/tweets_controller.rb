class TweetsController < ApplicationController



  def index
    @tweets = Tweet.all.page(params[:page]).per(10)
  end

  def new
    @tweet = Tweet.new
  end

  
end
