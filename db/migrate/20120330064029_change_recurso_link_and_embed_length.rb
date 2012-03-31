class ChangeRecursoLinkAndEmbedLength < ActiveRecord::Migration
  def up
    change_column :recursos, :link, :string, :limit => 1000
    change_column :recursos, :embed, :string, :limit => 1000
  end

  def down
    change_column :recursos, :link, :string
    change_column :recursos, :embed, :string
  end
end
