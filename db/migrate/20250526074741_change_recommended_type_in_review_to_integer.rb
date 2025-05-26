class ChangeRecommendedTypeInReviewToInteger < ActiveRecord::Migration[7.1]
  def change
    change_column :reviews, :recommended, :integer, using: 'recommended::integer'
  end
end
