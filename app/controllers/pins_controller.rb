class PinsController < ApplicationController

    def create
        @pin = Pin.new(pin_params.except(:redirect_map_id))
        @pin.user = current_user  # assign user manually
        @pin.map = Map.find(params[:pin][:map_id])  # assign map manually
        redirect_map_id = params[:pin][:redirect_map_id]
        if redirect_map_id.present? && @pin.save
            redirect_to map_path(redirect_map_id), notice: 'Pin was successfully created.'
        elsif @pin.save
            redirect_to map_path(@pin.map), notice: 'Pin was successfully created.'
        else
            redirect_to map_path(@pin.map), alert: 'Failed to create pin.'
        end
    end

    private
    def pin_params
        params.require(:pin).permit(:place_id, :label, :map_id, :redirect_map_id)
    end
end
