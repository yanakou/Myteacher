class TweetsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]



  def index
    @tweets = Tweet.all.page(params[:page]).per(10)
  end

  def new
    @tweet = Tweet.new
  end

  def create
  end

  def destroy
  end

  
end
