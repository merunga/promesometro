class DeviseCreateCiudadanos < ActiveRecord::Migration
  def change
    create_table(:ciudadanos) do |t|
      t.string :name, :default => nil, :null => true
      t.string :login, :default => nil
      t.string :login_type, :null => false
      #t.string :image, :default => nil, :null => true
      
      t.string :facebook
      t.string :twitter
      t.references :info_funcionario
      
      ## Database authenticatable
      t.string :email,              :null => false
      t.string :encrypted_password, :null => false, :default => ""

      t.database_authenticatable
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      t.lockable
      t.timestamps

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Encryptable
      # t.string :password_salt

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## Token authenticatable
      t.string :authentication_token

      t.timestamps
    end

    add_index :ciudadanos, :email,                :unique => true
    add_index :ciudadanos, :reset_password_token, :unique => true
    add_index :ciudadanos, :confirmation_token,   :unique => true
    add_index :ciudadanos, :unlock_token,         :unique => true
    add_index :ciudadanos, :authentication_token, :unique => true
  end
  
  def self.down
    drop_table :ciudadanos
  end
end
