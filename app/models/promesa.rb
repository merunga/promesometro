class Promesa < ActiveRecord::Base
  acts_as_taggable
  has_paper_trail(
    :only => [:lo_prometido, :fecha_compromiso],
    :on => [:create, :update]
  )
  
  belongs_to :ciudadano, :as => :creador
  belongs_to :ciudadano, :as => :funcionario, :through => :info_funcionario
  
  has_many :pruebas
end
