class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.database_authenticatable
      t.recoverable
      t.rememberable
      t.trackable
      t.lockable
      t.timestamps
      t.column  :login, :string, :default => nil
      t.column  :name, :string, :default => nil, :null => true
      t.column  :avatar_src, :string, :default => nil, :null => true
    end
    self.change_column :users, :email, :string, :null => true
  end

  def self.down
    drop_table :users
  end
end