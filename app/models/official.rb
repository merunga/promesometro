class Official < ActiveRecord::Base
  
  #
  # Associations
  #
  has_many :promises
  
  #
  # CarrierWave
  #
  mount_uploader :avatar, AvatarUploader
  
  #
  # Constants
  #
  POSITIONS = ['Alcalde','Presidente Regional','Presidente']
  
  #
  # Validates
  #
  validates :name, :presence => true
  validates :avatar, :presence => true
  validates :position, :presence => true
  
  def position_name
    POSITIONS[position]
  end
end
