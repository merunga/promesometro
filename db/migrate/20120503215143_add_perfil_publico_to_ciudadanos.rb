class AddPerfilPublicoToCiudadanos < ActiveRecord::Migration
  def change
    add_column :ciudadanos, :perfil_publico, :boolean, :default => true, :null => false
  end
end
