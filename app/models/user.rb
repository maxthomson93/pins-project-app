class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  acts_as_taggable_on :tags
  has_one_attached :photo

  has_many :reviews, dependent: :destroy
  has_many :memberships
  has_many :maps_as_follower, through: :memberships, source: :map
  has_many :maps_as_owner, class_name: 'Map', foreign_key: 'user_id'
  has_many :pins, dependent: :destroy
  has_many :pins_as_follower, through: :maps_as_follower, source: :pins

  def maps
    (maps_as_follower + maps_as_owner).uniq
  end
end
