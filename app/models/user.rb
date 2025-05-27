class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  acts_as_taggable_on :tags
  has_one_attached :photo

  has_many :reviews, dependent: :destroy
  has_many :pins, dependent: :destroy
  has_many :memberships, dependent: :destroy

  has_many :maps, dependent: :destroy
  has_many :maps_as_follower, through: :memberships, source: :maps

end
