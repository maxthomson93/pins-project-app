class MapsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    status = params[:status] || "communities"
    @status = status
	@@ -20,8 +23,8 @@ def index
     if params[:query].present?
      @maps = Map.where("name ILIKE ?", "%#{params[:query]}%").where(permission: :public_access)
      client = GooglePlaces::Client.new(ENV['GOOGLE_API_SERVER_KEY'])
      # You can use params[:lat] and params[:lng] for map center, or set defaults
      spots = client.spots_by_query(params[:query])

      @places = spots.map do |spot|
        Place.new(title: spot.name, latitude: spot.lat, longitude: spot.lng, address: spot.formatted_address, photo_url: spot.photos[0].fetch_url(400, {api_key: ENV['GOOGLE_API_SERVER_KEY']}) )
      end

    else
      @maps = Map.where(permission: "public_access")
      @places = []
    end
  end

  def show
    @map = Map.find(params[:id])
    @pins = @map.pins
    @places = @pins.map(&:place).uniq
    @maps = current_user.maps if user_signed_in?
    @pin = Pin.new
    @pin.map_id = params[:pin][:map_id] if params[:pin] && params[:pin][:map_id].present?
    @markers = @places.map do |place|
	@@ -30,18 +33,25 @@ def show

      {
        lat: place.latitude,
        lng: place.longitude,
        infoWindow: { content: render_to_string(partial: "/shared/place_card", locals: { place: place }) }
      }
    end
  end

  def new
    @map = Map.new
    @tags = given_tags
  end

  def create
    @map = Map.new(map_params)
    @map.user = current_user  # assign user manually
  if @map.save
    Membership.create!(user: current_user, map: @map)
    redirect_to @map
	@@ -50,10 +60,34 @@ def create
  else
    render :new, status: :unprocessable_entity
  end
end


  private

  def map_params
    params.require(:map).permit(:name, :description, :permission, :tag_list)
  end

  def given_tags
      %w[bars beaches beauty cafes cinemas  education fashion halal hikes hobby kosher lgbtq museums miscellaneous nature nightlife parks pet-friendly religious restaurants scenic sightseeing tradition vegan vegetarian wildlife yoga zen]
  end
end
