class Review < ApplicationRecord
  belongs_to :pin
  belongs_to :user
  enum recommended: [ :undecided, :like, :dislike ]
end
