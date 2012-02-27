class Province < ActiveRecord::Base
  belongs_to :state
  has_one :official

  default_scope order('name ASC')
  scope :used, :joins => {:state => {:officials => :promises}}, :group => "name"
end
