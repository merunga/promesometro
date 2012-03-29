class ActsAsVoteableMigration < ActiveRecord::Migration

  def self.up
    create_table :votes do |t|
      t.boolean :voting, :default => false
      t.datetime :created_at, :null => false
      t.references :voteable, :polymorphic => true
      t.references :ciudadano
    end

    add_index :votes, :voteable_type
    add_index :votes, :voteable_id
    add_index :votes, :ciudadano_id
  end

  def self.down
    drop_table :votes
  end

end
