class AddCompartidaConPromesas < ActiveRecord::Migration
  def change
    add_column :promesas, :compartida_con, :string, :length => 1000
  end
end
