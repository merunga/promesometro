class Declaration < ActiveRecord::Base
  #
  # Associations
  #
  belongs_to :promise

  attr_accessible :promise
end
