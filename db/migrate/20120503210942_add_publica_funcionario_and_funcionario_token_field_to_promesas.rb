class AddPublicaFuncionarioAndFuncionarioTokenFieldToPromesas < ActiveRecord::Migration
  def change
    remove_column :info_funcionarios, :funcionario_id
    
    change_table :promesas do |t|
      t.boolean :publica, :default => true, :null => false
      t.references :funcionario, :null => true
      t.string :hazte_cargo_token, :null => true, :length => 64
      t.datetime :hazte_cargo_created_at, :null => true
      t.string :hazte_cargo_email, :null => true, :length => 100
      t.string :hazte_cargo_body, :null => true, :length => 1000
    end
  end
end
