module SessionsHelper
  def log_in_user!(user)
    session[:token] = user.session_token
  end

  def log_out_user!
    current_user.reset_session_token!
    session[:token] = nil
    session[:vip_tour] = nil
  end

  def current_user
    current_user ||= User.find_by_session_token(session[:token])
  end

  def current_user_id
    current_user ? current_user.id : nil
  end

  def require_logged_in_user
    redirect_to new_session_url unless current_user
  end

  def prohibit_logged_in_user
    redirect_to root_url if current_user
  end

  def require_profile_owner
    redirect_to :back unless current_user.id == params[:id].to_i
  end
end
