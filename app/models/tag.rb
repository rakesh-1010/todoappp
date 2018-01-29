class Tag < ActiveRecord::Base
  belongs_to :user
  belongs_to :task


  def self.add_tag(user_id,task_id)
    Taging.create(user_id: user_id,task_id: task_id)
  end

  def remove_tag
    self.destroy
  end
end
