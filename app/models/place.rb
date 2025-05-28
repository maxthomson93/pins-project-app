class Place < ApplicationRecord
  has_many :pins, dependent: :destroy
  has_many :reviews
end
