class Reclamo < ActiveRecord::Base
  belongs_to :promesa
  belongs_to :ciudadano
  
  #def block!
  #  self.update_attribute(:blocked, true)
  #end
end
