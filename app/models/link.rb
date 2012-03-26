class Link < Recurso
  validates_presence_of :link
  validates :link, :format => URI::regexp(%w(http https))
end
