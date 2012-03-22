class CreateInfoFuncionarios < ActiveRecord::Migration
  def change
    create_table :info_funcionarios do |t|
      t.string :nombre, :null => false
      t.string :cargo
      t.string :entidad
      t.string :dni
      t.string :telefono
      t.references :promesa
      t.references :funcionario
      
      t.timestamps
    end
  end
end
