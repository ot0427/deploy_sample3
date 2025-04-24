class Goal < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :title, presence: true
  validates :description, presence: true
  has_many :progresses, dependent: :destroy
end
