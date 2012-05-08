class FollowersMailer < ActionMailer::Base
  def informar_cambio(emails, promesa, motivo)
    @promesa = promesa
    
    mail(:to => emails,
         :subject => "[promesometro.pe] #{motivo.capitalize}",
    )
  end
end
