module SessionsHelper
    # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
    #   find()の場合、sessionが切れるとエラーを起こしてしまうので
    #   nilで再度ログインを求めるfind_by()の方が適切
    #   ||=で無駄にfind_byを呼び出さないようにしている
    
  def current_user?(user)
    user==current_user
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def log_out
      session.delete(:user_id)
      @current_user=nil
  end
  
  # 記憶したURL (もしくはデフォルト値) にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end