class AddMonitoreadaToPruebas < ActiveRecord::Migration
  def change
    add_column :promesas, :monitoreada, :boolean, :default => FALSE
  end
end
