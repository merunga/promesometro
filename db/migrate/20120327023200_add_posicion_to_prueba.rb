class AddPosicionToPrueba < ActiveRecord::Migration
  def self.up
    add_column :pruebas, :posicion, :integer, :null => false
  end

  def self.down
    remove_column :pruebas, :posicion
  end
end
