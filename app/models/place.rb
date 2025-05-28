class Place < ApplicationRecord
  has_many :pins, dependent: :destroy
  def show
    # @place = Place.find(params[:id])
  end
end
