module SessionsHelper
  def log_in_user!(user)
    session[:token] = user.session_token
  end

  def log_out_user!
    current_user.reset_session_token!
    session[:token] = nil
    cookies[:vip_tour] = nil
  end

  def current_user
    current_user ||= User.find_by_session_token(session[:token])
  end

  def current_user_id
    current_user ? current_user.id : nil
  end

  def require_logged_in_user
    unless current_user
      cookies[:vip_tour] = nil
      redirect_to new_session_url 
    end
  end

  def prohibit_logged_in_user
    redirect_to root_url if current_user
  end

  def require_profile_owner
    redirect_to :back unless current_user.id == params[:id].to_i
  end
  
  def clean_up_michael!
    date = "2013-10-29 16:35:36"
    
    michael = User.find(1)
    Status.delete_all("created_at > '#{date}' AND user_id = 1")
    Response.delete_all("created_at > '#{date}' AND user_id = 1")
    Message.delete_all("created_at > '#{date}' AND user_id = 1")
  end
end
