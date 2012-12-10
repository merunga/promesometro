class PromesasController < ApplicationController
  load_and_authorize_resource
  autocomplete :region, :nombre, :full => true
  autocomplete :tag, :name, :full => true
  
  before_filter :create_search
  
  def denunciar
    if ciudadano_signed_in?
      @promesa = Promesa.new
      @promesa.info_funcionario = InfoFuncionario.new
      @promesa.uploader = current_ciudadano
      prueba = @promesa.pruebas.build
      prueba.link = Link.new
      prueba.archivo = Archivo.new
      prueba.imagen = Imagen.new
      prueba.video = Video.new
      prueba.mapa = Mapa.new
    else
     render 'shared/_not_logged_in'
    end
  end
  
  def prometer
    if ciudadano_signed_in?
      @promesa = Promesa.new
      @promesa.info_funcionario = InfoFuncionario.new
      @promesa.uploader = current_ciudadano
      @promesa.funcionario = current_ciudadano
      prueba = @promesa.pruebas.build
      prueba.link = Link.new
      prueba.archivo = Archivo.new
      prueba.imagen = Imagen.new
      prueba.video = Video.new
      prueba.mapa = Mapa.new
      avance = @promesa.avances.build(
        :link => Link.new,
        :archivo => Archivo.new,
        :imagen => Imagen.new,
        :video => Video.new,
        :mapa => Mapa.new
      )
      render 'denunciar'
    else
     render 'shared/_not_logged_in'
    end
  end
  
  def ver
    if @promesa.publica || (current_ciudadano && current_ciudadano.puede_ver?(@promesa)) 
      @promesa = Promesa.find(params[:id])
      @prueba = Prueba.new(
        :uploader => current_ciudadano,
        :link => Link.new(),
        :archivo => Archivo.new,
        :imagen => Imagen.new(),
        :video => Video.new(),
        :mapa => Mapa.new()
      )
      @comments = @promesa.root_comments.order('created_at asc').page(params[:page]).per(5)
   end
  end
  
  def crear
    @promesa = Promesa.new(params[:promesa])
    @info_funcionario = @promesa.info_funcionario
    if @promesa.valid?
      @info_funcionario.save
      @promesa.uploader = current_ciudadano
      if(params[:prometiendo])
        @promesa.funcionario = current_ciudadano
        @promesa.fecha_declaracion = nil
      end
      @promesa.pruebas.each do |p| p.uploader = current_ciudadano end
      @promesa.avances.each do |a| a.uploader = current_ciudadano end
      @promesa.save
      
      if @promesa.compartida_con
        emails = @promesa.compartida_con.split(',')
        emails.each do |email|
          PromeMailer.compartir(@promesa, current_ciudadano, email).deliver
        end
      end
      
      redirect_to ver_promesa_url(@promesa)
    else
      render :action => 'denunciar'
    end
  end
  
  def editar
    @promesa = Promesa.find(params[:id])
    prueba = @promesa.pruebas.build
    prueba.link = Link.new
    prueba.archivo = Archivo.new
    prueba.imagen = Imagen.new
    prueba.video = Video.new
    prueba.mapa = Mapa.new
    render :template => 'promesas/denunciar'
  end
  
  def actualizar
    p = params[:promesa]
    @promesa = Promesa.find(p[:id])
    if @promesa.update_attributes(p) 
      @promesa.save
      
      notificar_followers('promesa actualziada')
      
      redirect_to :action => 'ver'
    else
      redirect_to :action => 'editar'
    end
  end
  
  def ver_todas
  end
  
  def buscar
    @promesas = @search.order('created_at DESC').page params[:page]
  end
  
  def agregar_prueba
    @promesa = Promesa.find(params[:id])
    @prueba = Prueba.new(params[:prueba])
    @prueba.promesa = @promesa
    @prueba.uploader = current_ciudadano
    @prueba.posicion = @promesa.pruebas.count
    @prueba.save
    
    notificar_followers('nueva prueba agregada')
    
    if request.xhr?
      respond_to do |format|
        format.html {
          render 'prueba/_show', :layout => false, :locals => {:prueba => @prueba}
        }
      end
    else
      redirect_to :ver_promesa
    end
  end
  
  def comentar
    @promesa = Promesa.find(params[:id])
    @comment = Comment.build_from(
      @promesa,
      params[:comment][:ciudadano_id],
      params[:comment][:body]
    )
    @comment.save!
    
    notificar_followers('nuevo comentario creado')
    
    flash[:notice]= 'El comentario ha sido creado con exito'
    
    respond_to do |format|
      format.js
    end

    #render 'comments/_comment', :layout => false, :locals => {:comment => @comment, :level => 0, :position => 0}
  end
  
  def seguir
    @promesa=Promesa.find(params[:id])
    social_action('_seguir') {
      current_ciudadano.follow @promesa
    }
  end
  
  def dejar_de_seguir
    @promesa=Promesa.find(params[:id])
    social_action('_seguir') {
      current_ciudadano.stop_following @promesa
    }
  end
  
  def reclamar_cumplimiento
    @promesa=Promesa.find(params[:id])
    social_action('_reclamar') {
      current_ciudadano.reclamar_cumplimiento @promesa
    }
  end
  
  def dejar_de_reclamar_cumplimiento
    @promesa=Promesa.find(params[:id])
    social_action('_reclamar') {
      current_ciudadano.dejar_de_reclamar_cumplimiento @promesa
    }
  end
  
  def enviar_hazte_cargo
    @promesa = Promesa.find(params[:id])
    registrar_envio_de_hazte_cargo
    render :json => 'success'
  end
  
  def hacerme_cargo
    @promesa = Promesa.find(params[:id])
    token = params[:token]
    if(@promesa.hazte_cargo_token == token)
      @promesa.funcionario = current_ciudadano
      @promesa.save
    end
    redirect_to :editar_promesa
  end
  
  def lavarme_las_manos
    @promesa = Promesa.find(params[:id])
    token = params[:token]
    if(@promesa.hazte_cargo_token == token)
      @promesa.hazte_cargo_sender = nil
      @promesa.hazte_cargo_token = nil
      @promesa.hazte_cargo_nombre = nil
      @promesa.hazte_cargo_email = nil
      @promesa.hazte_cargo_body = nil
      @promesa.hazte_cargo_created_at = nil
      if(@promesa.funcionario == current_ciudadano)
        @promesa.funcionario = nil
      end
      @promesa.save
    end
    redirect_to :ver_promesa
  end
  
private
  def social_action(template, &block)
    @promesa = Promesa.find(params[:id])
    
    block.call
    
    respond_to do |format|
        format.html { render template, :layout => ! request.xhr?, :promesa => @promesa }
    end
  end
  
  def create_search
    @search = Promesa.publicas.search(params[:search])
  end
  
  def notificar_followers motivo
    emails = @promesa.followers.collect do |c| c.email end
    PromeMailer.cambio_promesa(emails, @promesa, motivo).deliver
  end
  
  def registrar_envio_de_hazte_cargo
    @promesa.hazte_cargo_sender = current_ciudadano
    @promesa.hazte_cargo_token = Digest::SHA1.hexdigest([Time.now, rand].join)
    @promesa.hazte_cargo_nombre = params[:nombre_responsable]
    @promesa.hazte_cargo_email = params[:email_responsable]
    @promesa.hazte_cargo_body = params[:email_body]
    @promesa.hazte_cargo_created_at = Time.now
    @promesa.save

    PromeMailer.hazte_cargo(@promesa).deliver
  end
end
