class Prueba < ActiveRecord::Base
  has_many :links, :imagens, :archivos, :videos, :mapas
end
