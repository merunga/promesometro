class AddHazteCargoFieldsToPromesa < ActiveRecord::Migration
  def change
    #remove_column :promesas, :funcionario_token
    
    change_table :promesas do |t|
      t.references :hazte_cargo_sender, :null => true
      t.string :hazte_cargo_token, :null => true, :length => 64
      t.datetime :hazte_cargo_created_at, :null => true
      t.string :hazte_cargo_nombre, :null => true, :length => 150
      t.string :hazte_cargo_email, :null => true, :length => 100
      t.string :hazte_cargo_body, :null => true, :length => 1000
    end
  end
end
