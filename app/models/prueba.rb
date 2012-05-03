class Prueba < ActiveRecord::Base
  acts_as_votable
  
  belongs_to :uploader, :class_name => 'Ciudadano'
  belongs_to :promesa
  
  has_one :recurso
  has_one :link
  has_one :imagen
  has_one :archivo
  has_one :video
  has_one :mapa
  
  accepts_nested_attributes_for :uploader
  accepts_nested_attributes_for :link
  accepts_nested_attributes_for :imagen
  accepts_nested_attributes_for :archivo
  accepts_nested_attributes_for :video
  accepts_nested_attributes_for :mapa
  
  validates_presence_of :descripcion
  attr_accessible :posicion, :descripcion, :anonima,
    :uploader, :link, :archivo, :imagen, :video, :mapa,
    :link_attributes, :imagen_attributes, :archivo_attributes,
    :video_attributes, :mapa_attributes, :uploader_attributes
  
  accepts_nested_attributes_for :link, :imagen, :archivo, :video, :mapa, :uploader
end
