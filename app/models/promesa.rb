class Promesa < ActiveRecord::Base
  acts_as_taggable
  has_paper_trail(
    :only => [:lo_prometido, :fecha_compromiso],
    :on => [:create, :update]
  )
  
  belongs_to :uploader, :class_name => 'Ciudadano', :inverse_of => :promesas_creadas
  has_one :info_funcionario
  has_many :pruebas, :order => 'posicion ASC'
  belongs_to :region
  has_one :funcionario, :class_name => 'Ciudadano', :through => :info_funcionario
  
  accepts_nested_attributes_for :info_funcionario
  accepts_nested_attributes_for :pruebas
  validates_presence_of :lo_prometido
  
  attr_accessible :fecha_declaracion, :info_funcionario_attributes, :tag_list,
    :lo_prometido, :slug, :region, :pruebas_attributes, :region_id, :denuncia_anonima
  
  def esta_legitimizada?
    info_funcionario.no.nil?
  end
  
  before_save :set_slug
  def set_slug
    self.slug = (self.info_funcionario.nombre+' prometio '+self.lo_prometido).parameterize
  end
  
  def screen_date
    return self.fecha_declaracion if self.fecha_declaracion
    self.created_at
  end
  
  def teaser
    el_que_promete+' prometio: '+lo_prometido[0,200] #+ ('...' if description.length > 200)
  end
  
  def el_que_promete
    info_funcionario.to_s
  end
  
  def el_que_denuncia
    if denuncia_anonima
      "denuncia anonima"
    else
      uploader.screen_name
    end
  end
end
