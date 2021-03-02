module LoginHelper
  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(user)
    post login_path, params: { session: { email: user.email,
                                          password: "000000"}}
  end
end

  