class Task < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :tagings
  validates :description, presence: true
end
