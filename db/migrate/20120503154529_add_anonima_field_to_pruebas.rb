class AddAnonimaFieldToPruebas < ActiveRecord::Migration
  def change
    add_column :pruebas, :anonima, :boolean, :default => false
  end
end
