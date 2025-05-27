class Map < ApplicationRecord
  enum :permission, { public_access: 0, private_access: 1 }
end
