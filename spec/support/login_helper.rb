module LoginHelper
  def is_logged_in?
    !session[:user_id].nil?
  end

  
end

  