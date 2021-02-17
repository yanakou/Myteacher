module SessionsHelper

  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  #現在ログイン中のユーザーを返す
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  #ログインしている時にtrueを返し、それ以外ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
  
end
