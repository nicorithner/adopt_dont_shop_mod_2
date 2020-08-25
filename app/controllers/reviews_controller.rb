class ReviewsController < ApplicationController

  def new
    # require "pry"; binding.pry
    @shelter = Shelter.find(params[:shelter_id])
  end
end
