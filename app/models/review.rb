class Review < ApplicationRecord
  belongs_to :place
  belongs_to :user
  enum recommended: [ :undecided, :like, :dislike ]
end
