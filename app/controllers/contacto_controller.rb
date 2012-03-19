class ContactoController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end
  
  def create
    @contact_form = ContactForm.new params[:contact_form]
    if @contact_form.valid?
      tipo = @contact_form.tipo
      ContactoMailer.send_email(@contact_form).deliver
      notice = 'Email enviado, pronto recibiras respuesta.' if tipo == 'contacto'
      notice = 'Denuncia recibida, te avisaremos sobre su avance.' if tipo == 'denuncia'
      redirect_to :action => :new, :notice => notice
    else
      render :new
    end
  end
end
