class MapsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    status = params[:status] || "communities"
    @status = status
    @place = Place.new
    if params[:query].present?
      @maps = Map.where("name ILIKE ?", "%#{params[:query]}%").where(permission: :public_access)
      @markers_by_map = {}
      @maps.each_with_index do |map, i|
        pins = map.pins.includes(:place)
        @markers_by_map[map.id] = pins.map do |pin|
          place = pin.place
          {
            lat: place.latitude,
            lng: place.longitude,
            infoWindow: { content: render_to_string(partial: "/shared/place_card", locals: { place: place }) },
            map_index: i,
            icon: {
              url: helpers.asset_url("pins/pin_main.png"),
              size: { width: 32, height: 32 },
              scaledSize: { width: 32, height: 32 }
            }
          }
        end
      end

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

    else
      @maps = Map.where(permission: "public_access")
      @markers_by_map = {}
      @maps.each_with_index do |map, i|
        pins = map.pins.includes(:place)
        @markers_by_map[map.id] = pins.map do |pin|
          place = pin.place
          {
            lat: place.latitude,
            lng: place.longitude,
            infoWindow: { content: render_to_string(partial: "/shared/place_card", locals: { place: place }) },
            map_index: i,
            icon: {
              url: helpers.asset_url("pins/pin_main.png"),
              size: { width: 32, height: 32 },
              scaledSize: { width: 32, height: 32 }
            }
          }
        end
      end
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
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  def map_params
    params.require(:map).permit(:name, :description, :permission, :tag_list)
  end

  def given_tags
      %w[food fashion nightlife nature culture wellness lifestyle]
  end
end
