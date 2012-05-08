class CompartirMailer < ActionMailer::Base
  def enviar(promesa, sender, email)
    @promesa = promesa
    @sender = sender
    
    mail(:to => email,
         :subject => "[promesometro.pe] #{@sender.screen_name} ha compartido una promesa contigo",
    )
  end
end
