module Social::MetaDataHelper
  def node_meta_data(model,id)
     case model
       when 'declaration' then
         @d = Declaration.find(params[:id])
         @p = @d.promise
         render :partial => 'social/meta_data_tags', :locals => {
             :model => 'declaration',
             :link => promesa_url(@p.slug),
             :title => "Declaracion de #{@p.official.name} acerca de #{@p.title}",
             :desc => @d.body
         }
     end
  end

  def page_meta_data
    render 'social/meta_data_tags', :title => '', :desc => '', :link => ''
  end
end
