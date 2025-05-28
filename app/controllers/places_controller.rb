class PlacesController < ApplicationController

  def show
    @place = Place.find(params[:id])
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
end
