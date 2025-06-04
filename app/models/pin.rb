class Pin < ApplicationRecord
  belongs_to :place
  belongs_to :map
  belongs_to :user

  # accepts_nested_attributes_for :place
end
