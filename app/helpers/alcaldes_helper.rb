module AlcaldesHelper
  def milestone_class(milestone)
    case milestone.state
    when 'new'
      'milestone_new'
    when 'in_progress'
      'milestone_started'
    when 'finished'
      'milestone_finished'
    end
  end
  
  def milestone_states(milestone)
    case milestone.state
    when 'new'
      'No Iniciado'
    when 'in_progress'
      'Iniciado'
    when 'finished'
      'Finalizado'
    end
  end
  
  def name_to_function(name)
    name.gsub(' ','_').gsub('á','a').gsub('é','e').gsub('í','i').gsub('ó','o').gsub('ú','u')
  end
end
