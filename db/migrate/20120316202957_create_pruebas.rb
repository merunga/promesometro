class CreatePruebas < ActiveRecord::Migration
  def change
    create_table :pruebas do |t|
      t.text :descripcion, :null => false
      
      t.timestamps
    end
  end
end
