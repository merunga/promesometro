class Province < ActiveRecord::Base
  belongs_to :state
  has_many :officials

  default_scope order('name ASC')
  scope :used, :joins => {:officials => :promises}, :group => "name"
end
