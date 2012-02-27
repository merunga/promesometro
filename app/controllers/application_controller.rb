class ApplicationController < ActionController::Base
  protect_from_forgery

  #before_filter :fix_metadata_header
  
  add_crumb "Home", '/'

  def after_sign_in_path_for(resource_or_scope)
    if request.env['omniauth.origin']
      request.env['omniauth.origin']
    end
  end
end
