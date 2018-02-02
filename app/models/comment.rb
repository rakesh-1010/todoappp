class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  validates :comment,:user_id,:task_id,presence: true
end
