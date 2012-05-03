class AddPublicaFuncionarioAndFuncionarioTokenFieldToPromesas < ActiveRecord::Migration
  def change
    remove_column :info_funcionario, :funcionario_id
    remove_index :info_funcionario, :funcionario_id
    
    change_table :promesas do |t|
      t.add_column :publica, :boolean, :default => true, :null => fals
      t.references :funcionario, :null => true
      t.add_column :funcionario_token, :string, :null => true, :length => 64
    end
    
  end
end
