module Social::MetaDataHelper
  def node_meta_data(model,id)
     case model
       when 'p' then
         p = Promesa.find(id)
         render :partial => 'social/meta_data_tags', :locals => {
             :link => ver_promesa_url(p)+"/?mdm=#{model}&mdi=#{id}",
             :title => p.teaser,
             :desc => p.lo_prometido
         }

       when 'c' then
         c = Comment.find(id)
         p = c.commentable
         render :partial => 'social/meta_data_tags', :locals => {
             :link => ver_promesa_url(p)+"/?mdm=#{model}&mdi=#{id}",
             :title => "#{c.ciudadano.screen_name} opina sobre a promesa de #{p.info_funcionario}: #{p.lo_prometido}",
             :desc => p.description
         }
     end
  end

  def page_meta_data
    render 'social/meta_data_tags',
       :title => 'promesometro.pe',
       :desc => 'Mide y discute el progreso de las promesas de tus representantes',
       :link => 'http://www.promesometro.pe'
  end

  def meta_data_tags(model,id)
    if model and id
      node_meta_data model, id
    else
      page_meta_data
    end
  end

  def promesa_social_widgets(p)
    render 'promesa_widgets',
      :link => ver_promesa_url(p)+"/?mdm=p&mdi=#{p.id}",
      :title => p.teaser,
      :desc => p.lo_prometido,
      :width => 280,
      :promesa => p
  end

  def comentario_social_widgets(c)
    p = c.commentable
    render 'social/node_widgets',
      :link => ver_promesa_url(p)+"/?mdm=c&mdi=#{c.id}",
      :title => "#{c.ciudadano.screen_name} opina sobre a promesa de #{p.info_funcionario}",
      :desc => p.lo_prometido
  end
end
