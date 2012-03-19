class InfoFuncionario < ActiveRecord::Base
  has_paper_trail(
    :only => [:nombre, :cargo, :entidad],
    :on => [:create, :update]
  )
end
