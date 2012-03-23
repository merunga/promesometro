class PromesasController < ApplicationController
  authorize_resource
  
  def denunciar
    @promesa = Promesa.new
    @promesa.info_funcionario = InfoFuncionario.new
  end
  
  def ver
    
  end
  
  def crear
    @promesa = Promesa.new(params[:promesa])
    @info_funcionario = @promesa.info_funcionario
    if @promesa.valid?
      @info_funcionario.save
      @promesa.uploader = current_user
      @promesa.save
      redirect_to @promesa
    end
    render :action => 'denunciar'
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
