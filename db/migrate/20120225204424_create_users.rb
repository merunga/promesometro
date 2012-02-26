class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :login_type, :string, :null => false
      t.column :login, :string, :default => nil
      t.column :name, :string, :default => nil, :null => true
      t.column :image, :string, :default => nil, :null => true

      t.database_authenticatable
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      t.lockable
      t.timestamps
    end
    self.change_column :users, :email, :string, :null => true
  end

  def self.down
    drop_table :users
  end
end