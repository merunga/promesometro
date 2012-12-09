class CiudadanoController < ApplicationController
  def seguir
    
  end
  
  def ver_perfil
    
  end

  def new
  	@ciudadano=Ciudadano.new
  	respond_to do |format|
      unless ciudadano_signed_in?
  	    format.html
      else
        format.html{redirect_to root_path}
      end
  	end
  end

  def create
    params[:ciudadano][:login]=params[:ciudadano][:email]
  	
    ciudadano = Ciudadano.where(:email => params[:ciudadano][:email])
    @ciudadano = Ciudadano.new(params[:ciudadano]) 
    
    respond_to do |format|
      if !ciudadano.blank?

        flash[:notice] = "Ya existe un ciudadano registrado con ese Email"
        format.html { redirect_to :root }
      elsif params[:ciudadano][:password] != params[:ciudadano][:password_confirmation]
        flash[:notice] = "Las passwords no coinciden"
        format.html { render :action => "new" }
      elsif  @ciudadano.save  
        flash[:notice] = "Confirm su direccion de correo"

        # @ciudadano.send_confirmation_instructions
        format.html{redirect_to root_path}
      else
        format.html { render :action => "new" }
      end
    end
  end

  def inicio
    @ciudadano=Ciudadano.new
    respond_to do |format|
      unless ciudadano_signed_in?
        format.html
      else
        format.html{redirect_to root_path}
      end
    end
  end

  def sesion_new
    @ciudadano=Admin.where(:email=>params[:ciudadano][:email]).first
    @ciudadano=Ciudadano.where(:email=>params[:ciudadano][:email]).first if @ciudadano.blank?
    @ciudadano=Ciudadano.where(:login=>params[:ciudadano][:email]).first if @ciudadano.blank?
    respond_to do |format|
      if !@ciudadano.blank?  && @ciudadano.valid_password?(params[:ciudadano][:password])
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "email"
        sign_in @ciudadano
        format.html{redirect_to root_path}
        
      else
        flash[:notice] = "Error de usuario o password"
        @ciudadano=Ciudadano.new if @ciudadano.blank?
        format.html{render :action=>'inicio'}
      end
    end
  end

  def recovery_password
    @ciudadano=Ciudadano.new
    respond_to do |format|
      unless ciudadano_signed_in?
        format.html
      else
        format.html{redirect_to root_path}
      end
    end
  end

  def reset_password
    @ciudadano=Ciudadano.where(:email=>params[:ciudadano][:email]).first
    respond_to do |format|
      if !@ciudadano.blank?  
        @ciudadano.send_reset_password_instructions
        flash[:notice] = 'Verifique su correo.'
        format.html{redirect_to root_path}
        
      else
        flash[:notice] = "Error usuario no registrado"
        @ciudadano=Ciudadano.new if @ciudadano.blank?
        format.html{render :action=>'recovery_password'}
      end
    end
  end
end
