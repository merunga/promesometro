module Social::MetaDataHelper
  def node_meta_data(model,id)
     case model
       when 'declaration' then
         @d = Declaration.find(id)
         @p = @d.promise
         render :partial => 'social/meta_data_tags', :locals => {
             :link => promesa_url(@p.slug)+"/?md[]=#{model}&md[]=#{id}",
             :title => "Declaracion de #{@p.official.name} acerca de #{@p.title}",
             :desc => @d.body
         }
     end
  end

  def page_meta_data
    render 'social/meta_data_tags',
         :title => 'promesometro.pe',
         :desc => 'Mide y discute el progreso de las promesas de tus representantes',
         :link => 'http://promesometro.pe'
  end

  def meta_data_tags(node=nil)
    if node
      node_meta_data node[0], node[1]
    else
      page_meta_data
    end
  end
end
