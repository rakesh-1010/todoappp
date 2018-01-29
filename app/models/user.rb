class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tasks
  has_many :tags,through: :tasks
  has_many :comments,through: :tasks

  def tagged_tasks
    tags.map{|tag| tag.task}
  end

  def all_tasks
    self.tasks + self.tagged_tasks
  end

end
