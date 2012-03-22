class PromesasController < ApplicationController
  def denunciar
    @promesa = Promesa.new
    @promesa.info_funcionario = InfoFuncionario.new
  end
  
  def ver
    
  end
  
  def crear
    @promesa = Promesa.new(params[:promesa])
    if @promesa.save
      redirect_to @promesa
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
