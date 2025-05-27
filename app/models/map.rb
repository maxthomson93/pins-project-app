class Map < ApplicationRecord
  enum permission: { public_access: 0, shared_access: 1, private_access: 1 }
end
