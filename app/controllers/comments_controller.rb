class CommentsController < ApplicationController
  before_action :set_tweet, only: %i[create edit update destroy]
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = @tweet.comments.create(comment_params)
    if @comment.save
      @tweet.create_notification_comment!(current_user, @comment.id)
      @comment = Comment.new
    end
    gets_all_comments
  end

  def edit; end

  def update
    @comment.update(comment_params)
    gets_all_comments
    # if @comment.update(comment_params)
    #     gets_all_comments
    # end
  end

  def destroy
    gets_all_comments if @comment.destroy
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def gets_all_comments
    @comments = @tweet.comments.includes(:user).order('created_at asc')
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
