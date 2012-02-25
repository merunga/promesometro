class Declaration < ActiveRecord::Migration
  def self.up
    create_table :declarations do |t|
      t.string  :title, :default => ""
      t.text    :body
      t.integer :promise_id

      t.timestamps
    end
  end

  def self.down
  end
end
