class Promesa < ActiveRecord::Base
  scope :publicas, where(:publica => true)
  scope :by_newest, :order => "promesas.created_at DESC"
  scope :by_oldest, :order => "promesas.created_at ASC"
  
  acts_as_commentable
  acts_as_taggable
  acts_as_followable
  
  search_methods :tag_list
  
  paginates_per 8

  has_paper_trail(
    :only => [:lo_prometido, :fecha_compromiso],
    :on => [:create, :update]
  )
  
  belongs_to :uploader, :class_name => 'Ciudadano', :inverse_of => :promesas_creadas    
  belongs_to :funcionario, :class_name => 'Ciudadano', :inverse_of => :promesas_propias
  belongs_to :hazte_cargo_sender, :class_name => 'Ciudadano', :inverse_of => :hazte_cargo_enviados
  belongs_to :region
  
  has_one :info_funcionario
  has_many :pruebas, :order => 'id ASC'
  has_many :avances, :order => 'created_at DESC'
  has_many :reclamos, :order => 'id ASC'
  
  accepts_nested_attributes_for :info_funcionario
  accepts_nested_attributes_for :pruebas, :allow_destroy => true
  accepts_nested_attributes_for :avances, :allow_destroy => true
  validates_presence_of :lo_prometido
  
  attr_accessible :fecha_declaracion, :info_funcionario_attributes, :tag_list,
    :lo_prometido, :slug, :region, :pruebas_attributes, :region_id, :denuncia_anonima,
    :publica, :fecha_compromiso, :avances_attributes, :compartida_con, :posicion
    
  def fecha_inicio
    return fecha_declaracion if fecha_declaracion
    return created_at
  end
  
  def puede_enviar_hazte_cargo?
    no.esta_legitimizada? && (
      !hazte_cargo_token || (Time.now-hazte_cargo_created_at) > 30
    )
  end
  
  def esta_legitimizada?
    funcionario.not.nil?
  end
  
  def esta_asumida?
    esta_legitimizada? && hazte_cargo_token
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
