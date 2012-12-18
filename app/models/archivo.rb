class Archivo < Recurso
  validates_presence_of :file
  mount_uploader :file, ArchivoPruebaUploader
  attr_accessible :file_cache
end
