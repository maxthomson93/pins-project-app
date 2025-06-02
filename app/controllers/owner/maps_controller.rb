class Owner::MapsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if current_user
      @maps = current_user.maps
      @pins = @maps.map(&:pins).flatten
      @places = @pins.map(&:place).uniq
      @colors = %w[red blue green orange purple brown]


      @markers = @places.map do |place|
        map = place.pins.first.map
        map_index = @maps.index(map)
        color = @colors[map_index % @colors.length]
        {
          lat: place.latitude,
          lng: place.longitude,
          icon: {
            url: helpers.asset_url("pins/pin_#{color}.png"),
            size: { width: 32, height: 32 },
            scaledSize: { width: 32, height: 32 }
          },
          infoWindow: { content: render_to_string(partial: "/shared/place_card", locals: { place: place }) },
          color: color,
          map_index: map_index
          # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
          # Uncomment the above line if you want each of your markers to display a info window when clicked
          # (you will also need to create the partial "/flats/map_box")
        }
      end
    # else
    #   @markers = []
    end

  end
end
