class InfoFuncionario < ActiveRecord::Base
  has_paper_trail(
    :only => [:nombre, :cargo, :entidad],
    :on => [:create, :update]
  )
  belongs_to :promesa
  belongs_to :funcionario, :class_name => :ciudadano
  validates_presence_of :nombre
end
