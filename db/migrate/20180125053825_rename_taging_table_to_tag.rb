class RenameTagingTableToTag < ActiveRecord::Migration
  def self.up
    rename_table :tagings,:tags
  end

  def self.down
    rename_table :tags,:tagings
  end
end
