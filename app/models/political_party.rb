class PoliticalParty < ActiveRecord::Base
  
  #
  # Associations
  #
  has_many :officials
  
  #
  # CarrierWave
  #
  mount_uploader :logo, LogoUploader

  default_scope order('name ASC')
  scope :with_promises, :joins =>{:officials => :promises}, :group => "name"
end
