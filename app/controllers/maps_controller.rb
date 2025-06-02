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

  def new
    @map = Map.new
  end
def create
  @map = Map.new(map_params)
  @map.user = current_user  # assign user manually

  if @map.save
    redirect_to @map
  else
    render :new, status: :unprocessable_entity
  end
end


  private

  def map_params
    params.require(:map).permit(:name, :description, :permission)
  end
end
