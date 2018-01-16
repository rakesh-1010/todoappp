class AddUserNameToTaging < ActiveRecord::Migration
  def change
    add_column :tagings, :user_name, :string
  end
end
