class MapsController < ApplicationController
  # Permitimos ver el índice y el detalle sin necesidad de login
  skip_before_action :authenticate_user!, only: [:index, :show]

  # GET /maps
  def index
    status = params[:status] || "communities"
    @status = status
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
    @map    = Map.find(params[:id])
    @pins   = @map.pins
    @places = @pins.map(&:place).uniq
    @maps = current_user.maps if user_signed_in?
    @pin = Pin.new
    @pin.map_id = params[:pin][:map_id] if params[:pin] && params[:pin][:map_id].present?
    @markers = @places.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        infoWindow: {
          content: render_to_string(
            partial: "shared/place_card",
            locals: { place: place }
          )
        }
      }
    end
  end

  # GET /maps/new
  def new
    @map = Map.new
  end

  # POST /maps
  def create
    @map = Map.new(map_params)
    @map.user = current_user

  if @map.save
    redirect_to @map
  else
    render :new, status: :unprocessable_entity
  end
end

  # GET /maps/:id/edit
  def edit
    @map = Map.find(params[:id])
  end

  # PATCH/PUT /maps/:id
  def update
    @map = Map.find(params[:id])

    if @map.update(map_params)
      redirect_to map_path(@map), notice: "Mapa actualizado correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /maps/:id
  def destroy
    @map = Map.find(params[:id])
    @map.destroy

    redirect_to maps_path, notice: "Mapa eliminado."
  end

  private

  def map_params
    params.require(:map).permit(:name, :description, :public)
    # (ajusta los atributos permitidos según tu modelo)
  end
end
