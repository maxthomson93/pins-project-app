class MapsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    if params[:query].present?
      @maps = Map.where("name ILIKE ?", "%#{params[:query]}%").where(permission: :public_access)
    else
      @maps = Map.where(permission: "public_access")
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
      Membership.create(user: current_user, map: @map)  # create membership for the user
      redirect_to @map
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  def map_params
    params.require(:map).permit(:name, :description, :permission)
  end

  def given_tags
      %w[bars beaches beauty cafes cinemas  education fashion halal hikes hobby kosher lgbtq museums miscellaneous nature nightlife parks pet-friendly religious restaurants scenic sightseeing tradition vegan vegetarian wildlife yoga zen]
  end
end
