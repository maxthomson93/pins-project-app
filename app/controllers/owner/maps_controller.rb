class Owner::MapsController < ApplicationController
    def index
      @maps = current_user.maps
      @pins = @maps.map(&:pins).flatten
      @places = @pins.map(&:place).uniq
      colors = %w[red blue green orange purple]

      @markers = @places.map do |place|
        map = place.pins.first.map
        map_index = @maps.index(map)
        color = colors[map_index % colors.length]
        {
          lat: place.latitude,
          lng: place.longitude,
          color: color,
          map_index: map_index
          # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
          # Uncomment the above line if you want each of your markers to display a info window when clicked
          # (you will also need to create the partial "/flats/map_box")
        }
      end
  end
end
