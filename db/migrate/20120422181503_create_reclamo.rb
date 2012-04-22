class CreateReclamo < ActiveRecord::Migration
  def self.up
    create_table :reclamos, :force => true do |t|
      t.references :promesa, :null => false
      t.references :ciudadano, :null => false
      #t.boolean :blocked, :default => false, :null => false
      t.timestamps
    end

    add_index :reclamos, "promesa_id",   :name => "fk_reclamados"
    add_index :reclamos, "ciudadano_id", :name => "fk_reclamantes"
  end

  def self.down
    drop_table :reclamos
  end
end
