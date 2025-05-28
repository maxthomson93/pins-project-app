class Place < ApplicationRecord
  has_many :pins, dependent: :destroy
  has_many :maps, through: :pins
  has_many :reviews
end
