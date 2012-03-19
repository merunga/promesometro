class ComentarioMailer < ActionMailer::Base

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

    mail(:bcc => emails, :subject => subject) do |format|
      format.html
      format.text
    end
  end

  def welcome(ciudadano)
    subject = '[promesometro.pe] Bienvenido ciudadano a construir con el Promesometro'
    @display_name = ciudadano.contact_name
    @account_type = ciudadano.login_type
    @login = ciudadano.login

    mail(:to => ciudadano.email,
         :subject => subject) do |format|
      format.html
      format.text
    end
  end

  def new_from_emails(emails, curr_ciudadano)
    if curr_ciudadano and curr_ciudadano.screen_name
      display_name = curr_ciudadano.screen_name
    else
      display_name = I18n.t('muck.comment.anonymous')
    end
    @display_name = display_name
    #subject = "[promesometro.pe] Novedades sobre la Promesa de #{} de %NombrePromesa%!"

    mail(:from => @mail_address, :bcc => emails,
        :subject => I18n.t('muck.comments.new_comment_email_subject',
        :name => display_name, :application_name => 'promesometro')) do |format|
      format.html
      format.text
    end
  end
end