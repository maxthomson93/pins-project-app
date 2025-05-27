class Map < ApplicationRecord
  belongs_to :user
  has_many :memberships
  has_many :pins
  has_many :users, through: :memberships
  has_many :places, through: :pins
  enum permission: { public_access: 0, shared: 1, private_access: 2 }

  acts_as_taggable_on :tags
  validates :name, presence: true
end
