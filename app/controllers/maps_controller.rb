class MapsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    status = params[:status] || "communities"
    @status = status
	@@ -20,8 +23,8 @@ def index
  end

  def show
    @map = Map.find(params[:id])
    @pins = @map.pins
    @places = @pins.map(&:place).uniq
    @maps = current_user.maps if user_signed_in?
    @pin = Pin.new
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
  end

  def create
    @map = Map.new(map_params)
    @map.user = current_user  # assign user manually

  if @map.save
    redirect_to @map
	@@ -50,10 +60,34 @@ def create
  end
end


  private

  def map_params
    params.require(:map).permit(:name, :description, :permission)
  end
end
