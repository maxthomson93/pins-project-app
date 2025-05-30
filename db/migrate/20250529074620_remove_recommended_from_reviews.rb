class RemoveRecommendedFromReviews < ActiveRecord::Migration[7.1]
  def change
    remove_column :reviews, :recommended
  end
end
