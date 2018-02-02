class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.boolean :is_completed
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
