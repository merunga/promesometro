class AddPosicionToPromesas < ActiveRecord::Migration
  def change
    add_column :pruebas, :posicion, :integer
  end
end
