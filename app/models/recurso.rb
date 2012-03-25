class Recurso < ActiveRecord::Base
  belongs_to :prueba
  attr_accessible :type, :link, :file, :embed
  
  validates :link, :format => URI::regexp(%w(http https))
end
