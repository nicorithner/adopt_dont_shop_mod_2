class Shelters_petController < ApplicationController
    def index
    # binding.pry
    # @shelter = Shelter.find(params[:id]).pets
    @shelter = Shelter.find(params["shelter_id"]).pets
  end
end