class Embed < Recurso
  validates_presence_of :embed
  before_save :sanitize_embed
  
  def sanitize_embed
    #self.embed = sanitize recurso.embed, :tags => %w(iframe)
    #Sanitize.clean(content, YourApp::SANITIZE_FILTER)
  end
end
