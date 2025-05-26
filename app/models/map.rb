class Map < ApplicationRecord
  belongs_to :user
  enum permission: [ :public, :shared, :private ]
end
