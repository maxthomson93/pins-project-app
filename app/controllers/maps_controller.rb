class MapsController < ApplicationController
  def index
    if params[:query].present?
      @maps = Map.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @maps = Map.all
    end
  end

  def show
    @map = Map.find(params[:id])
  end
end
