module Social::MetaDataHelper
  def node_meta_data(model,id)
     case model
       when 'd' then
         @d = Declaration.find(id)
         @p = @d.promise
         render :partial => 'social/meta_data_tags', :locals => {
             :link => promesa_url(@p.slug)+"/?mdm=d&mdi=#{id}",
             :title => "Declaracion de #{@p.official.name} acerca de #{@p.title}",
             :desc => @d.body
         }

       when 'p' then
         @p = Promise.find(id)
         render :partial => 'social/meta_data_tags', :locals => {
             :link => promesa_url(@p.slug)+"/?mdm=p&mdi=#{id}",
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

  def promise_social_widgets(p)
    render 'social/node_widgets',
      :link => promesa_url(p.slug)+"/?mdm=p&mdi=#{p.id}",
      :title => p.title,
      :desc => p.description,
      :width => 280
  end

  def declaration_social_widgets(d)
    p = d.promise
    render 'social/node_widgets',
      :link => promesa_url(p.slug)+"/?mdm=d&mdi=#{d.id}",
      :title => "Declaracion de #{p.official.name} acerca de #{p.title}",
      :desc => d.body,
      :width => 280
  end
end