class PromesasController < ApplicationController
  #load_and_authorize_resource
  
  def denunciar
    @promesa = Promesa.new
    @promesa.info_funcionario = InfoFuncionario.new
    @promesa.pruebas.build.recursos.build.type='Link'
  end
  
  def ver
    @promesa = Promesa.find(params[:id])
  end
  
  def crear
    @promesa = Promesa.new(params[:promesa])
    @info_funcionario = @promesa.info_funcionario
    if @promesa.valid?
      @info_funcionario.save
      logger.debug current_ciudadano
      @promesa.uploader = current_ciudadano
      @promesa.pruebas.each do |p| p.uploader = current_ciudadano end
      @promesa.save
      redirect_to ver_promesa_url(@promesa)
    else
      render :action => 'denunciar'
    end
  end
  
  def editar
  end
  
  def ver_todas
  end
  
  def buscar
    
  end
  
  def agregar_prueba
  end
  
  def seguir
  end
  
  def reclamar_cumplimiento
  end
  
  def hacerse_cargo
  end
  
  def lavarse_las_manos
  end
end
