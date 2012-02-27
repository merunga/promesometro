class State < ActiveRecord::Base
  #
  # Associations
  #
  has_many :provinces
  has_many :officials

  default_scope order('name ASC')
  scope :used, :joins =>{:officials => :promises}, :group => "name"
end
