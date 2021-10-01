class Room < ApplicationRecord
  has_one_attached :photo
  has_many :reservations, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :introduction,
    presence: true,
    length: {maximum: 50}
  validates :adress, presence: true
  validates :price, presence: true
  validates :photo, presence: true
end
