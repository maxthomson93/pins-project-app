class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  acts_as_taggable_on :tags
  has_one_attached :photo

  has_many :memberships
  has_many :maps, through: :memberships
end
