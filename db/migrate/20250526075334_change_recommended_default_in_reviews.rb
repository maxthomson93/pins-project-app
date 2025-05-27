class ChangeRecommendedDefaultInReviews < ActiveRecord::Migration[7.1]
  def change
    change_column_default :reviews, :recommended, 0
  end
end
