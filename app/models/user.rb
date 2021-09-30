class User < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :reservations
  has_secure_password
  has_one_attached :avatar

  validates :name,
    presence: true,
    length: {maximum: 20}
  validates :email,
    uniqueness: true,
    presence: true
  validates :introduction, length: {maximum: 50}
  validates :password, on: :create,
    presence: true,
    confirmation: true,
    length: {minimum: 6}
  validates :password, on: :update,
    confirmation: true,
    length: {minimum: 6}, if: Proc.new{|user| user.password.present?}
end
