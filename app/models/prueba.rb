class Prueba < ActiveRecord::Base
  has_many :links
  has_many :imagenes
  
  has_many :archivos
  has_many :videos
  has_many :mapas
end
