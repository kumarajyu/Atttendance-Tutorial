module SessionsHelper
  
  # 引数に渡されたユーザーオブジェクトでログインします。
  def log_in(user)
    session[:user_id] = user.id
  end
  
   # セッションと@current_userを破棄します
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  # 現在ログイン中のユーザーがいる場合オブジェクトを返します。
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  # 渡されたユーザーがログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == current_user
  end
  
  # 現在ログイン中のユーザーがいればtrue、そうでなければfalseを返します。
  def logged_in?
    !current_user.nil?
  end
  
  # 記憶しているURL (もしくはデフォルト値) にリダイレクトする
  def redirect_back_or(default)
    redirect_to(session[:fowarding_url] || default)
    session.delete(:fowarding_url)
  end
  
  # アクセスしようとしたURLを記憶しておく
  def store_location
    session[:fowarding_url] = request.original_url if request.get?
  end
end
