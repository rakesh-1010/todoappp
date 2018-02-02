class RemoveUserNameFromTaging < ActiveRecord::Migration
  def change
    remove_column :tagings, :user_name
  end
end
