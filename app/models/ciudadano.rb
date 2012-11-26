class Ciudadano < ActiveRecord::Base       
  acts_as_tagger
  acts_as_follower
  acts_as_voter
  
  devise :database_authenticatable, :lockable, :recoverable,
      :rememberable, :registerable, :trackable, :timeoutable,
      :token_authenticatable, :omniauthable

  attr_accessible :login, :login_type, :email, :name,
    :password, :password_confirmation, :send_notifications,
    :perfil_publico
  
  has_many :promesas_creadas, :inverse_of => :uploader, :class_name => 'Promesa'
  has_many :promesas_propias, :inverse_of => :funcionario, :class_name => 'Promesa'
  has_many :pruebas_creadas, :inverse_of => :uploader, :class_name => 'Prueba'
  has_many :hazte_cargo_enviados, :inverse_of => :hazte_cargo_sender, :class_name => 'Promesa'

  def es_uploader_de? una_cosa
    una_cosa && una_cosa.uploader == self
  end
  
  def es_funcionario_de? una_promesa
    una_promesa && una_promesa.funcionario == self
  end
  
  def puede_editar? esta_promesa
    (esta_promesa.no.esta_legitimizada? && esta_promesa.uploader = self) ||
    esta_promesa.funcionario = self
  end
  
  def puede_ver? esta_promesa
    puede_editar? esta_promesa ||
    esta_promesa.compartida_con.include?(self.email)
  end
  
  ### RECLAMOS
  def reclamando?(promesa)
    Reclamo.where(
      'promesa_id = :promesa_id and ciudadano_id = :ciudadano_id',
      :promesa_id => promesa.id, :ciudadano_id => self.id
    ).count > 0
  end
  
  def reclamar_cumplimiento(promesa)
    Reclamo.create(:promesa => promesa, :ciudadano => self)
  end
  
  def dejar_de_reclamar_cumplimiento(promesa)
    Reclamo.where(
      'promesa_id = :promesa_id and ciudadano_id = :ciudadano_id',
      :promesa_id => promesa.id, :ciudadano_id => self.id
    ).delete_all
  end
  ###
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    ciudadano = Ciudadano.where(:email => data.email).first
    if not ciudadano
      ciudadano = Ciudadano.create!(
          :email => data.email,
          :login => data.email,
          :login_type => 'facebook',
          :name => "#{data.first_name} #{data.last_name}",
          :password => Devise.friendly_token[0,20]
          # :image => access_token.info.image
      )
      PromeMailer.welcome(ciudadano).deliver
    end
    ciudadano
  end
  
  def self.new_with_session(params, session)
    super.tap do |ciudadano|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        ciudadano.email = data.email
      end
    end
  end
  
  def self.find_for_open_id(access_token, signed_in_resource=nil)
    data = access_token.info
    ciudadano = Ciudadano.where(:email => data.email).first
    if not ciudadano
      ciudadano=Ciudadano.create!(
          :email => data.email,
          :login => data.email,
          :login_type => 'google',
          :password => Devise.friendly_token[0,20]
      )
      PromeMailer.welcome(ciudadano).deliver
    end
    ciudadano
  end
  
  def self.find_for_twitter(access_token, signed_in_resource=nil)
    data = access_token.info
    nickname = "@#{data.nickname}"
    ciudadano = Ciudadano.where(:login => nickname).first
    if not ciudadano
      ciudadano = Ciudadano.create!(
        :login => nickname,
        :login_type => 'twitter',
        :password => Devise.friendly_token[0,20]
      )
      #PromeMailer.welcome(ciudadano).deliver
    end
    ciudadano
  end

  def screen_name
    if perfil_publico
      return name || 'un ciudadano'
    else
      return 'anonimo'
    end
  end

  def contact_name
    if self.name and not self.name.blank?
      self.name
    elsif self.login
      self.login
    else
      self.email
    end
  end
end
