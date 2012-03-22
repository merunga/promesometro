class Promesa < ActiveRecord::Base
  acts_as_taggable
  has_paper_trail(
    :only => [:lo_prometido, :fecha_compromiso],
    :on => [:create, :update]
  )
  
  belongs_to :uploader, :class_name => :ciudadano, :inverse_of => :promesas
  has_one :info_funcionario  
  #has_one :funcionario, :class_name => :ciudadano, :through => :info_funcionario
  
  has_many :pruebas
  
  def esta_legitimizada?
    info_funcionario.no.nil?
  end
  
  before_save :set_slug
  def set_slug
    self.slug = self.title.parameterize
  end
end
