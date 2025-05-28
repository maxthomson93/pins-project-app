class Owner::MapsController < ApplicationController
    def index
      @maps = current_user.maps
      @places = Place.where.not(latitude: nil, longitude: nil)

      @markers = @places.map do |place|
        {
          lat: place.latitude,
          lng: place.longitude
          # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
          # Uncomment the above line if you want each of your markers to display a info window when clicked
          # (you will also need to create the partial "/flats/map_box")
        }
      end
  end
end
