class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :timeline]
  before_action :set_user, only: [:show, :edit, :update, :likes, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :join_room, only: [:show, :likes]
  before_action :blocking_edit_test_user, only: [:edit, :update]

  def index
    @users = User.all.page(params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @tweets = @user.tweets.includes(:taggings).order('created_at desc').page(params[:page]).per(10)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "MyTeacherへようこそ！"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "プロフィールを変更しました"
      redirect_to @user
    else
      flash.now[:alert] = "入力内容に誤りがあります。入力漏れ、文字数をご確認ください。"
      render 'edit'
    end
  end

  def likes
    @tweets = @user.liked_tweets.includes(%i[taggings user]).order('updated_at desc').page(params[:page]).per(10)
  end

  def following
    @users = @user.following
  end

  def followers
    @users = @user.followers
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url
  end

  def timeline
    @user = User.find(current_user.id)
    @following_users = @user.following
    @tweets = Tweet.includes(%i[taggings user]).where(user_id: @following_users).order('created_at desc').page(params[:page]).per(10)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                            :password_confirmation, :avatar)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def blocking_edit_test_user
    redirect_to root_path, alert: "ゲストユーザーのため編集できません" if current_user.email == "guest.user@guest.com"
  end

  def join_room
    if logged_in?
      @currentUserEntry = Entry.where(user_id: current_user.id)
      @userEntry = Entry.where(user_id: @user.id)
      unless @user.id == current_user.id
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id
              @haveRoom = true
              @roomId = cu.room_id
            end
          end
        end
        unless @haveRoom
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
  end
end
