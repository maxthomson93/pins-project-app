class Map < ApplicationRecord
  belongs_to :user
  enum permission: { public_access: 0, shared: 1, private_access: 2 }
  acts_as_taggable_on :tags
end
