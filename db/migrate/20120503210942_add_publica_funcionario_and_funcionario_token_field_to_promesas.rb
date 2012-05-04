class AddPublicaFuncionarioAndFuncionarioTokenFieldToPromesas < ActiveRecord::Migration
  def change
    #remove_column :info_funcionarios, :funcionario_id
    
    change_table :promesas do |t|
      t.boolean :publica, :default => true, :null => false
      t.references :funcionario, :null => true
      t.string :funcionario_token, :null => true, :length => 64
    end
  end
end
