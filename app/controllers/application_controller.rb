class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to ciudadano_session_url, :message => exception.message
  end
  
  def after_sign_in_path_for(resource)
    puts request.env['omniauth.origin']
    return request.env['omniauth.origin']
  end
  
  def current_ability
    @current_ability ||= Ability.new(current_ciudadano)
  end

  #before_filter :fix_metadata_header
  
  add_crumb "Home", '/'

  def after_sign_in_path_for(resource_or_scope)
    if request.env['omniauth.origin']
      request.env['omniauth.origin']
    else
      root_url
    end
  end
end
