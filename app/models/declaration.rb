class Declaration < ActiveRecord::Base
  
  #
  # Associations
  #
  belongs_to :promise
  
  #
  # Scopes
  #
  scope :government, where(:kind => 'government')
  
  #
  # Callbacks
  #
  class << self
    def new_government(args)
      self.new args.merge({:kind => 'government', :approved => true})
    end
  end
  
  def citizen?
    self.kind == 'citizen'
  end
  
  def government?
    self.kind == 'government'
  end
end
