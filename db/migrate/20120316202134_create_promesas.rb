class CreatePromesas < ActiveRecord::Migration
  def change
    create_table :promesas do |t|
      t.text :lo_prometido, :null => false
      t.references :info_funcionario, :null => false
      t.date :fecha_declaracion, :null => false
      t.references :region
      t.references :ciudadano, :as => :uploader, :null => false
      t.date :fecha_compromiso
      
      t.timestamps
    end
  end
end
