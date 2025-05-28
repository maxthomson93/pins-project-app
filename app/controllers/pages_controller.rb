class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @maps = Map.all # used for a temp partial
  end
end
