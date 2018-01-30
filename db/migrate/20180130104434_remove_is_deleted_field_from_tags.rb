class RemoveIsDeletedFieldFromTags < ActiveRecord::Migration
  def change
    remove_column :tags, :is_deleted, :boolean
  end
end
