class Social::MetaDataController < ApplicationController
  def declaration
    @d = Declaration.find(params[:id])
    @p = @d.promise
    render :partial => 'social/meta_data', :locals => {
      :model => 'declaration',
      :link => ver_promesa_url(@p),
      :title => "Declaracion de #{@p.official.name} acerca de #{@p.title}",
      :desc => @d.body
    }
  end
end
