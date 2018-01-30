class AddIsDeletedFieldToTags < ActiveRecord::Migration
  def change
    add_column :tags, :is_deleted, :boolean,default: false
  end
end
