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
    date = "2013-11-08 19:35:44"
    
    Status.delete_all("created_at > '#{date}' AND user_id = 1")
    Response.delete_all("created_at > '#{date}' AND user_id = 1")
    Message.delete_all("created_at > '#{date}' AND user_id = 1")
    Friendship.delete_all("created_at > '#{date}' AND friender_id = 1")
    
    Notification.update_all("unread = 'TRUE'", "user_id = 1")
    Delivery.update_all("unread = 'TRUE'", "user_id = 1")
    
    User.find(1).update_attributes(
      tagline: "Bluth Company President",
      summary: "Jean shorts anim XOXO, sed twee single-origin coffee narwhal cliche before they sold out excepteur Pinterest Blue Bottle cred. Gastropub cillum beard, Pitchfork cupidatat Neutra irony consectetur irure bitters. Ex scenester mollit, flexitarian sed irony consectetur bespoke. Delectus single-origin coffee sartorial, beard non disrupt nesciunt meggings sed culpa occaecat duis pour-over. Polaroid Banksy Portland, 90's mixtape leggings incididunt paleo readymade iPhone nihil pickled wayfarers ea. Sriracha fanny pack Portland forage. Hashtag fashion axe gluten-free commodo aute.\n\nMustache nostrud voluptate bicycle rights, cardigan beard church-key skateboard seitan try-hard. Tempor 8-bit bitters semiotics Thundercats delectus. Trust fund banjo irure, mollit PBR&B kitsch tote bag bicycle rights hoodie freegan. Truffaut four loko ex Terry Richardson 3 wolf moon. Placeat selvage hella, eiusmod vinyl messenger bag culpa distillery tempor. Vice Helvetica ad, occupy selfies paleo Godard aesthetic viral quinoa Neutra Odd Future Marfa. Dolore VHS pour-over, commodo Intelligentsia craft beer Terry Richardson.\n\nDIY stumptown deserunt cardigan, non kitsch odio. Church-key vero deep v, et selvage labore hella freegan cornhole High Life pop-up. Mollit proident ennui, exercitation Cosby sweater tofu +1. Letterpress craft beer polaroid tousled kogi accusamus. Truffaut fanny pack irony tofu hella ugh. Elit nisi pork belly put a bird on it eiusmod, pickled et do church-key master cleanse bespoke banjo. Nisi wayfarers food truck try-hard laboris Shoreditch.\n\nYr Intelligentsia Blue Bottle leggings deep v. Post-ironic slow-carb tousled occaecat. Scenester adipisicing cliche, delectus hashtag banh mi duis kitsch McSweeney's Shoreditch deep v nulla keffiyeh velit. Next level disrupt selvage, vegan organic cray selfies meh dolore locavore. Art party ugh assumenda, paleo direct trade chambray gastropub. Narwhal mumblecore laboris post-ironic aliqua fugiat. Flannel narwhal pariatur, kale chips est magna jean shorts enim seitan incididunt swag single-origin coffee deserunt selfies.",
      city: "Orange County",
      state: "CA",
      industry: "Real Estate",
      pic: File.new("public/images/seeds/michael.jpg")
    )
  end
end
