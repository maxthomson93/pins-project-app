class ReviewsController < ApplicationController
  def create
    @place = Place.find(params[:place_id])
    @review = @place.reviews.new(review_params)
    @review.user = current_user # or whatever user assignment you need

    if @review.save
      redirect_to place_path(@place), notice: "Review added!"
    else
      redirect_to place_path(@place), alert: "Review failed."
    end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
