class Social::MetaDataController < ApplicationController
  def declaration
    @d = Declaration.find(params[:id])
    @p = @d.promise
    render :partial => 'social/meta_data', :locals => {
      :model => 'declaration',
      :link => promesa_url(@p.slug),
      :title => "Declaracion de #{@p.official.name} acerca de #{@p.title}",
      :desc => @d.body
    }
  end
end
