class ApplicationController < ActionController::Base
  protect_from_forgery
  
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
