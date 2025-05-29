class PlacesController < ApplicationController

  def show
    @place = Place.find(params[:id])
    @reviews = @place.reviews
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
    @place.liked_by current_user
    respond_to do |format|
      format.html { redirect_to @place }
      format.json { render json: { votes: @place.get_upvotes.size } }
    end
  end
end
