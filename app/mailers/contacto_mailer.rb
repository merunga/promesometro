class ContactoMailer < ActionMailer::Base
  def send_email(cform)
    prepend = 'Nueva'
    prepend = 'ATENTO! Nueva' if cform.tipo == 'denuncia'
    mail(:from => cform.email,
         :subject => "[promesometro.pe] #{prepend} #{cform.tipo} #{cform.nombre}",
         :body => cform.comentario)
  end
end