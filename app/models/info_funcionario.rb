class InfoFuncionario < ActiveRecord::Base
  has_paper_trail(
    :only => [:nombre, :cargo, :entidad],
    :on => [:create, :update]
  )
  belongs_to :promesa
  belongs_to :funcionario, :class_name => 'Ciudadano'
  validates_presence_of :nombre
  
  def to_s
    retval = self.nombre
    if self.cargo.no.blank? && self.entidad.no.blank?
      retval += ", #{self.cargo} de #{self.entidad}"
    elsif self.cargo.no.blank?
      retval += ", #{self.cargo}"
    elsif self.entidad.no.blank?
      retval += ", miembro de #{self.entidad}"
    end
    return retval
  end
end
