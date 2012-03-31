class Prueba < ActiveRecord::Base
  belongs_to :uploader, :class_name => 'Ciudadano'
  belongs_to :promesa
  
  has_one :recurso
  has_one :link
  has_one :imagen
  has_one :archivo
  has_one :video
  has_one :mapa
  
  validates_presence_of :descripcion
  attr_accessible :posicion, :descripcion, :link_attributes,
    :imagen_attributes, :archivo_attributes, :video_attributes, :mapa_attributes,
    :uploader_attributes
  
  accepts_nested_attributes_for :link, :imagen, :archivo, :video, :mapa, :uploader
end
