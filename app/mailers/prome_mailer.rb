class PromeMailer < ActionMailer::Base
  default :from => 'merunga@gmail.com'
  
  def new_comment(comment)
    if comment.ciudadano
      display_name = comment.ciudadano.screen_name
    else
      display_name = I18n.t('muck.comment.anonymous')
    end
    @comment = comment
    @display_name = display_name
    @account_type = comment.ciudadano.login_type
    @login = comment.ciudadano.login
    emails = comment.emails_to_notify
    p = comment.commentable
    @promise =  p.title
    @official = p.official.name
    @promise_link = promesa_url p.slug
    subject = "[promesometro.pe] Novedades sobre la Promesa de #{@promise} de #{@official}"

    mail(:bcc => emails, :subject => subject)
    #do |format|
    #  format.html
    #  format.text
    #end
  end

  def welcome(ciudadano)
    subject = '[promesometro.pe] Bienvenido ciudadano a construir con el Promesometro'
    @from = ciudadano.contact_name
    @display_name = ciudadano.contact_name
    @account_type = ciudadano.login_type
    @login = ciudadano.login

    mail(:to => ciudadano.email, :subject => subject)
    #do |format|
    #  format.html
    #  format.text
    #end
  end

  def compartir(promesa, sender, email)
    @promesa = promesa
    @sender = sender
    
    mail(:to => email,
         :subject => "[promesometro.pe] #{@sender.screen_name} ha compartido una promesa contigo",
    )
  end
  
  def contacto(cform)
    mail(:from => cform.email,
         :subject => "[promesometro.pe] Nueva mail de contacto de #{cform.nombre}",
         :body => cform.comentario,
         :to=> 'merunga@gmail.com')
  end
  
  def hazte_cargo(promesa)
    @promesa = promesa
    @sender = @promesa.hazte_cargo_sender
    
    mail(:to => @promesa.hazte_cargo_email,
         :subject => "[promesometro.pe] #{@sender.screen_name} quiere que te hagas cargo de una promesa",
    )
  end
  
  def cambio_promesa(emails, promesa, motivo)
    @promesa = promesa
    
    mail(:bcc => emails,:subject => "[promesometro.pe] #{motivo.capitalize}") do |format|
      format.text
    end
  end
end
