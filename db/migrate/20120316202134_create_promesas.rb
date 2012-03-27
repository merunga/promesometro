class CreatePromesas < ActiveRecord::Migration
  def change
    create_table :promesas do |t|
      t.text :lo_prometido, :null => false
      #t.references :info_funcionario, :null => false
      t.date :fecha_declaracion
      t.references :region
      t.references :uploader, :null => false
      t.date :fecha_compromiso
      t.boolean :denuncia_anonima, :default => false
      
      t.text :slug
      t.timestamps
    end
  end
  
  def self.down
    drop_table :promesas
  end
end
