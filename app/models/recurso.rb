class Recurso < ActiveRecord::Base
  belongs_to :prueba
  attr_accessible :type, :link, :file, :embed
end
