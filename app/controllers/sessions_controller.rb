class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_back_or user
    else
      flash.now[:alert] = '無効なメールアドレス/パスワードの組み合わせです'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
