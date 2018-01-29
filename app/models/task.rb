class Task < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :tags, dependent: :destroy
  validates :description, presence: true

  def tagged_user_ids
    tags.map{|tag| tag.user_id}
  end

  def tag_exists_for(user)
    tagged_user_ids.include?user.id.to_s
  end

  def tag(user)
    tags.create(user_id: user.id)
  end

  def untag(user)
    tags.find_by(user_id: user.id).destroy
  end
end
