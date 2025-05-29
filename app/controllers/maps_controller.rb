class MapsController < ApplicationController

  def index
    if params[:query].present?
      @maps = Map.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @maps = current_user.maps
      @pins = @maps.map(&:pins).flatten
      @places = @pins.map(&:place).uniq
      @colors = %w[red blue green orange purple pink yellow ltblue]

      @markers = @places.map do |place|
        map = place.pins.first.map
        map_index = @maps.index(map)
        color = @colors[map_index % colors.length]
        {
          lat: place.latitude,
          lng: place.longitude,
          # icon: {
          #   url: helpers.asset_url("pins_logo.png"),
          #   size: { width: 32, height: 32 },
          #   scaledSize: { width: 32, height: 32 }
          # },
          infoWindow: { content: render_to_string(partial: "/shared/place_card", locals: { place: place }) },
          color: color,
          map_index: map_index
          # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
          # Uncomment the above line if you want each of your markers to display a info window when clicked
          # (you will also need to create the partial "/flats/map_box")
        }
      end
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
        icon: {
          url: helpers.asset_url("pins_logo.png"),
          size: { width: 32, height: 32 },
          scaledSize: { width: 32, height: 32 }
        },
        infoWindow: { content: render_to_string(partial: "/shared/place_card", locals: { place: place }) }
      }
    end
  end
end
