class Task < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :tagings, dependent: :destroy
  validates :description, presence: true
end
