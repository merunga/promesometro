class Promesa < ActiveRecord::Base
  acts_as_taggable
  has_paper_trail(
    :only => [:lo_prometido, :fecha_compromiso],
    :on => [:create, :update]
  )
  
  belongs_to :uploader, :class_name => 'Ciudadano', :inverse_of => :promesas_creadas
  has_one :info_funcionario
  has_many :pruebas
  belongs_to :region
  has_one :funcionario, :class_name => 'Ciudadano', :through => :info_funcionario
  
  accepts_nested_attributes_for :info_funcionario, :pruebas
  validates_presence_of :lo_prometido, :fecha_declaracion
  
  attr_accessible :fecha_declaracion, :info_funcionario_attributes, :tag_list,
    :lo_prometido, :slug, :region
  
  def esta_legitimizada?
    info_funcionario.no.nil?
  end
  
  before_save :set_slug
  def set_slug
    self.slug = (self.info_funcionario.nombre+' prometio '+self.lo_prometido).parameterize
  end
end
