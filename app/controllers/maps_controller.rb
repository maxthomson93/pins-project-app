class MapsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    if params[:query].present?
      @maps = Map.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @maps = Map.all
    end
  end

  def show
    @map = Map.find(params[:id])
    @pins = @map.pins
    @places = @pins.map(&:place).uniq
    @markers = @places.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        infoWindow: { content: render_to_string(partial: "/shared/place_card", locals: { place: place }) }
      }
    end
  end
end
