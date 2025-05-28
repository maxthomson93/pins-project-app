class Owner::MapsController < ApplicationController
    def index
      @maps = current_user.maps
      @pins = @maps.map(&:pins).flatten
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
