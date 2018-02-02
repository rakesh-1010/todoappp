class CreateTagings < ActiveRecord::Migration
  def change
    create_table :tagings do |t|
      t.string :user_id
      t.string :task_id

      t.timestamps null: false
    end
  end
end
