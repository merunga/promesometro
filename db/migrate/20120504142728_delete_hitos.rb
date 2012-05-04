class DeleteHitos < ActiveRecord::Migration
  def up
    drop_table :hitos
  end
end
