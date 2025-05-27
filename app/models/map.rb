class Map < ApplicationRecord
  belongs_to :user
  # has_one_attached :photo
  enum permission: { public_access: 0, shared_access: 1, private_access: 2 }

end
