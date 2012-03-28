class CreateEmbedes < ActiveRecord::Migration
  def change
    create_table :embedes do |t|

      t.timestamps
    end
  end
end
