class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :goals, dependent: :destroy
  has_many :progresses, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :terms_accepted, acceptance: { accept: true, message: "利用規約に同意してください" }
end
