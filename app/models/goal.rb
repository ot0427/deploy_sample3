class Goal < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :title, presence: true
  validates :description, presence: true
  has_many :progresses, dependent: :destroy
  has_many :comments, dependent: :destroy
  scope :published, -> { where(is_published: true) }
end
