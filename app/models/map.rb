class Map < ApplicationRecord
  belongs_to :user
  has_many :pins
  has_many :places, through: :pins
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  enum permission: { public_access: 0, shared: 1, private_access: 2 }

  acts_as_taggable_on :tags
  validates :name, presence: true
end
