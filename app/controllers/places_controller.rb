class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:upvote]
  def show
    @place = Place.find(params[:id])
    @reviews = @place.reviews.order(created_at: :desc)
  end

  def search
    if params[:query].present?
      client = GooglePlaces::Client.new(ENV['GOOGLE_API_SERVER_KEY'])
      # You can use params[:lat] and params[:lng] for map center, or set defaults
      spots = client.spots_by_query(params[:query])

      @results = spots.map do |spot|
        {
          lat: spot.lat,
          lng: spot.lng,
        }
      end
    else
      @results = []
    end

    respond_to do |format|
      format.json { render json: @results }
    end
  end

  def upvote
    @place = Place.find(params[:id])
    if current_user.liked?(@place)
      @place.unliked_by current_user
    else
    @place.liked_by current_user
    end
    respond_to do |format|
      format.html { redirect_to @place }
      format.json { render json: { votes: @place.get_upvotes.size, liked: current_user.liked?(@place) } }
    end
  end
end
