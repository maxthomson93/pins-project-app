class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:upvote]
  def show
    @place = Place.find(params[:id])
    @reviews = @place.reviews.order(created_at: :desc)
    @map = Map.find(params[:map_id]) if params[:map_id].present?
    @pin = Pin.new
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

  def create
    @place = Place.new(place_params)

    if @place.save
      Pin.create!(
        user: current_user,
        place: @place,
        map_id: params[:map_id]
      )
      redirect_to map_path(params[:map_id]), notice: "Place and Pin created!"
    else
      redirect_to maps_path, alert: "Failed to create place: #{@place.errors.full_messages.join(', ')}"
    end
  end


  def search
    @map = Map.find(params[:map_id])
    client = GooglePlaces::Client.new(ENV['GOOGLE_API_SERVER_KEY'])

    spots = client.spots(35.6895, 139.6917, name: params[:query], radius: 20_000)

    @places = spots.map do |spot|
      photo_url = spot.photos&.first&.fetch_url(400, { api_key: ENV['GOOGLE_API_SERVER_KEY'] }) || view_context.image_path("thebeach.jpg")
      Place.new(
        title: spot.name,
        latitude: spot.json_result_object["geometry"]["location"]["lat"],
        longitude: spot.json_result_object["geometry"]["location"]["lng"],
        address: spot.json_result_object["vicinity"],
        photo_url: photo_url
      )
    end


    respond_to do |format|
      format.html
    end

  end


  private

  def place_params
    params.require(:place).permit(:title, :address, :latitude, :longitude, :photo_url, :map_id)
  end

end
