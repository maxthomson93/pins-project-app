class MapsController < ApplicationController
  def index
    if params[:query].present?
      @maps = Map.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @maps = Map.all
    end
  end
end
