module Social::MetaDataHelper
  def node_meta_data(model,id)
     case model
       when 'declaration' then
         @d = Declaration.find(id)
         @p = @d.promise
         render :partial => 'social/meta_data_tags', :locals => {
             :link => promesa_url(@p.slug)+"/?mdm=#{model}&mdi=#{id}",
             :title => "Declaracion de #{@p.official.name} acerca de #{@p.title}",
             :desc => @d.body
         }

       when 'promise' then
         @p = Promise.find(id)
         render :partial => 'social/meta_data_tags', :locals => {
             :link => promesa_url(@p.slug)+"/?mdm=#{model}&mdi=#{id}",
             :title => @p.title,
             :desc => @p.description
         }
     end
  end

  def page_meta_data
    render 'social/meta_data_tags',
         :title => 'promesometro.pe',
         :desc => 'Mide y discute el progreso de las promesas de tus representantes',
         :link => 'http://promesometro.pe'
  end

  def meta_data_tags(model,id)
    if model and id
      node_meta_data model, id
    else
      page_meta_data
    end
  end
end
