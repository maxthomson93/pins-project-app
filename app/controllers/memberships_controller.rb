class MembershipsController < ApplicationController
  def create
    @map = Map.find(params[:map_id])
    @membership = Membership.new(user: current_user, map: @map)

    if @membership.save
      redirect_to @map, notice: "Joined the map!"
    else
      redirect_to @map, alert: "Could not join the map."
    end
  end
end
