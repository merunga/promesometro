class Declaration < ActiveRecord::Migration
  def self.up
    create_table :declarations do |t|
      t.string  :title, :default => ""
      t.text    :body
      t.integer :promise_id
      t.string  :kind

      t.timestamps
    end

    drop_table :comments
  end

  def self.down
  end
end
