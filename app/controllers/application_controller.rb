class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :fix_metadata_header
  
  add_crumb "Home", '/'

  def after_sign_in_path_for(resource_or_scope)
    if request.env['omniauth.origin']
      request.env['omniauth.origin']
    end
  end

  def fix_metadata_header
    node = request.params[:md]
    if node
      @metadata = view_context.node_meta_data *node
    else
      @metadata = view_context.page_meta_data
    end
  end
end
