class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  class User < ApplicationRecord
  acts_as_taggable_on :tags  # or :categories
  end

  class Map < ApplicationRecord
    acts_as_taggable_on :tags  # same context
  end
end
