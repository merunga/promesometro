class AddSendNotificationsToUsers < ActiveRecord::Migration
  def self.up
    self.add_column :users, :send_notifications, :bool, :default => true
    self.add_column :users, :share_email, :bool, :default => false
  end

  def self.down
  end
end
