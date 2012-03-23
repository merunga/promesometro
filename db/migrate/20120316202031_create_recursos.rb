class CreateRecursos < ActiveRecord::Migration
  def change
    create_table :recursos do |t|
      t.references :prueba
      t.string :type
      t.string :link
      t.string :embed
      t.string :file
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :recursos
  end
end
