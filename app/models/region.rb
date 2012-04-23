class Region < ActiveRecord::Base
  default_scope order('nombre ASC')
  
  def to_s
    nombre
  end
end
