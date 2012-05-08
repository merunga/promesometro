class HazteCargoMailer < ActionMailer::Base
  def enviar(promesa)
    @promesa = promesa
    @sender = @promesa.hazte_cargo_sender
    
    mail(:to => @promesa.hazte_cargo_email,
         :subject => "[promesometro.pe] #{@sender.screen_name} quiere que te hagas cargo de una promesa",
    )
  end
end
