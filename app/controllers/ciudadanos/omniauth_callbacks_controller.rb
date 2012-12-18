class Ciudadanos::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model
    logger.info("VALLL =  #{request.env["omniauth.auth"].to_json}")
    @ciudadano = Ciudadano.find_for_facebook_oauth(request.env["omniauth.auth"], current_ciudadano)
    if !@ciudadano.confirmed? 
      flash[:notice] = "Debe Confirmar su Email. Revise su correo."
      sign_in_and_redirect @ciudadano, :event => :authentication
    elsif @ciudadano.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @ciudadano, :event => :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_ciudadano_registration_url
    end
  end
  
  def google
    @ciudadano = Ciudadano.find_for_open_id(request.env["omniauth.auth"], current_ciudadano)
    if !@ciudadano.confirmed? 
      flash[:notice] = "Debe Confirmar su Email. Revise su correo."
      sign_in_and_redirect @ciudadano, :event => :authentication
    elsif @ciudadano.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"#, :profile_link_tag => edit_ciudadano_registration_path
      sign_in_and_redirect @ciudadano, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_ciudadano_registration_url
    end
  end

  def twitter
    @ciudadano = Ciudadano.find_for_twitter(request.env["omniauth.auth"], current_ciudadano)

    if @ciudadano.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
      sign_in_and_redirect @ciudadano, :event => :authentication
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      redirect_to new_ciudadano_registration_url
    end
  end
end
