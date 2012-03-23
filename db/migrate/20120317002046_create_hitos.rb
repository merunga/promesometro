class CreateHitos < ActiveRecord::Migration
  def change
    create_table :hitos do |t|
      t.references :prueba , :null => false
      t.string :descripcion, :null => false
      t.boolean :completado

      t.timestamps
    end
  end
  
  def self.down
    drop_table :hitos
  end
end
