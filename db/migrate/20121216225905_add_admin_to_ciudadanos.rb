class AddAdminToCiudadanos < ActiveRecord::Migration
  def change
    add_column :ciudadanos, :admin, :boolean

  end
end
