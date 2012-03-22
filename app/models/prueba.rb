class Prueba < ActiveRecord::Base
  belongs_to :upload, :class_name => :ciudadano
  
  has_many :links
  has_many :imagenes
  
  has_many :archivos
  has_many :videos
  has_many :mapas
end
