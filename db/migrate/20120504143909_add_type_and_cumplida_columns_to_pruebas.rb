class AddTypeAndCumplidaColumnsToPruebas < ActiveRecord::Migration
  def change
    add_column :pruebas, :type, :string, :null => false, :default => 'Prueba'
    add_column :pruebas, :cumplida, :boolean, :default => false
  end
end
