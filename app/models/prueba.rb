class Prueba < ActiveRecord::Base
  belongs_to :upload, :class_name => 'Ciudadano'
  belongs_to :promesa
  
  validates_presence_of :descripcion
  
  has_many :recursos
  
  accepts_nested_attributes_for :recursos
end
