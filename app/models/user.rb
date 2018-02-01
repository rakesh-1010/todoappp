class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tasks
  has_many :tags
  has_many :comments,through: :tasks
  has_many :tagged_tasks,through: :tags, :source => :task

  def all_tasks
    self.tasks + self.tagged_tasks
  end

end
