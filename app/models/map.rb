class Map < ApplicationRecord
  belongs_to :user
  enum permission: [ :public, :shared, :private ]
  acts_as_taggable_on :tags
end
