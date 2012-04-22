module PromesasHelper
  def mensaje_dias(promise,hito=nil)
    milestones = promise.milestones
    if milestones.started.count == 0 and milestones.completed.count == 0 then
      "Todavia no comienza la ejecucion"
    elsif milestones.started.count > 0 and milestones.not_started.count == 0 then
      "Promesa cumplida"
    elsif milestones.started.count > 0 then #en progreso
      if not hito
         hito = promise.hito_actual
=begin
        curr_hitos = promise.milestones.filter{|h| h.state == :in_progress }
        if !curr_hitos.empty? then
          hito = curr_hitos.each_with_index.inject(curr_hitos.first){|min, (h,i)|
            h.started_at < min.started_at ? h : min
          }
        end
=end
      end
      diff = Time.now()-hito.ended_at
      if diff < 0 then
        "Segun prometido, faltan #{diff} dias para verificar el cumplimiento del hito"
      elsif diff == 0 then
        "Hoy es la fecha limite de este hito, todavia no hemos verificado su cumplimiento"
      else
        "Han pasado #{diff} dias pero aun no hemos verificado el cumplimiento del hito"
      end
    end
  end

  
  def titulo_filtro_promesas(filtro)
    concat content_tag(:h2, "Filtrado por tema: #{filtro['topics_name_contains'].humanize}") unless filtro['topics_name_contains'].blank?
    concat content_tag(:h2, "Busqueda por promesa: #{filtro['title_contains'].humanize}") unless filtro['title_contains'].blank?
    concat content_tag(:h2, "Busqueda por representante: #{filtro['official_name_contains'].humanize}") unless filtro['official_name_contains'].blank?
    concat content_tag(:h2, "Busqueda por region: #{filtro['official_state_name_contains'].humanize}") unless filtro['official_state_name_contains'].blank?
    concat content_tag(:h2, "Busqueda por partido politico: #{filtro['official_political_party_name_contains'].humanize}") unless filtro['official_political_party_name_contains'].blank?
    concat content_tag(:h2, "Busqueda por tema: #{filtro['topics_contains'].humanize}") unless filtro['topics_contains'].blank?
    concat content_tag(:h2, "Busqueda por dias de progreso: #{filtro['dias_progreso_contains'].humanize}") unless filtro['dias_progreso_contains'].blank?
  end

  
  def comentarios_count(promesa)
    concat(content_tag(:span, promesa.comment_threads.count.to_s + " Comentarios", :class => 'comentarios_counter'))
  end

end
