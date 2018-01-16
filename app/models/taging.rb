class Taging < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  def self.add_tag(user_id,task_id,user_name)
    Taging.create(user_id: user_id,task_id: task_id,user_name: user_name)
  end

  def remove_tag
    self.destroy
  end
end
