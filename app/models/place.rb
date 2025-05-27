class Place < ApplicationRecord
  has_many :pins
  has_many :reviews
end
