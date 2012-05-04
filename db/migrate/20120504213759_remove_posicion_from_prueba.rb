class RemovePosicionFromPrueba < ActiveRecord::Migration
  def change
    remove_column :pruebas, :posicion
  end
end
