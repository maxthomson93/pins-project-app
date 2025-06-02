class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  acts_as_taggable_on :tags
  has_one_attached :photo
  acts_as_voter

  has_many :reviews, dependent: :destroy
  has_many :memberships
  has_many :maps_as_follower, through: :memberships, source: :map
  has_many :maps_as_owner, class_name: 'Map', foreign_key: 'user_id', dependent: :destroy
  has_many :pins, dependent: :destroy
  has_many :pins_as_follower, through: :maps_as_follower, source: :pins

  after_create :create_favorite_map

  def favorite_map
    maps_as_owner.find_by(name: "Favorite")
  end

  def maps
    (maps_as_follower + maps_as_owner).uniq
  end

  private

  def create_favorite_map
    favorite_map = maps_as_owner.create!(name: "Favorite", description: "My favorite places")
    memberships.find_or_create_by!(map: favorite_map)
  end
end
