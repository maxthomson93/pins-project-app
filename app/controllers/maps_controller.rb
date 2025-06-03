class MapsController < ApplicationController
  # Permitimos ver el índice y el detalle sin necesidad de login
  skip_before_action :authenticate_user!, only: [:index, :show]

  # GET /maps
  def index
    # Si quieres mostrar **todos** los mapas (comunidades), descomenta la siguiente línea:
    @maps = Map.all

    # Si en cambio quieres que el índice muestre solamente los mapas del usuario logueado,
    # usa esta otra línea y comenta la de arriba:
    # @maps = user_signed_in? ? current_user.maps : Map.none

    # Ahora @maps nunca será nil, así que en la vista index.html.erb podrás usar:
    #   pluralize(@maps.count, "community")
    # sin que lance error.
  end

  # GET /maps/:id
  def show
    @map    = Map.find(params[:id])
    @pins   = @map.pins
    @places = @pins.map(&:place).uniq

    # Si el usuario está logueado, tomamos sus mapas para algún uso en la vista
    @maps = current_user.maps if user_signed_in?

    # Preparamos un nuevo pin en caso de que la vista lo necesite (por formulario, etc.)
    @pin = Pin.new
    # Si vienen parámetros como params[:pin][:map_id], los asignamos automáticamente
    @pin.map_id = params[:pin][:map_id] if params[:pin]&.dig(:map_id).present?

    # Construimos el array de marcadores para Google Maps (latitudes, longitudes, contentHTML)
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
      redirect_to map_path(@map), notice: "Mapa creado correctamente."
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
