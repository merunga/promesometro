class CommentMailer < ActionMailer::Base

  def new_comment(comment)
    if comment.user
      display_name = comment.user.screen_name
    else
      display_name = I18n.t('muck.comment.anonymous')
    end
    @comment = comment
    @display_name = display_name
    @account_type = comment.user.login_type
    @login = comment.user.login
    emails = emails_for_comment(comment)
    emails.delete(comment.user.email)
    p = comment.commentable
    @promise =  p.title
    @official = p.official.name
    @promise_link = promesa_url p.slug
    subject = "[promesometro.pe] Novedades sobre la Promesa de #{@promise} de #{@official}"

    mail(:bcc => emails_for_comment(comment),
         :subject => subject) do |format|
      format.html
      format.text
    end
  end

  def welcome(user)
    subject = '[promesometro.pe] Bienvenido ciudadano a construir con el Promesometro'
    @display_name = user.contact_name
    @account_type = user.login_type
    @login = user.login

    mail(:to => user.email,
         :subject => subject) do |format|
      format.html
      format.text
    end
  end

  def new_from_emails(emails, curr_user)
    if curr_user and curr_user.screen_name
      display_name = curr_user.screen_name
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
  
  protected
    def emails_for_comment(comment)
      emails = []
      #Comment.find_comments_for_parent(comment) do |c|
      parent = comment.commentable_type.classify.constantize.find(comment.commentable_id)
      parent.comment_threads.each do |c|
        emails << c.user.email unless emails.include?(c.user.email) if c.user and c.user.send_notifications
      end
      emails
    end
    
end