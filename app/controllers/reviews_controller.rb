class ReviewsController < ApplicationController

  def new
    # require "pry"; binding.pry
    @shelter = Shelter.find(params[:shelter_id])
    @shelter_id = params[:shelter_id]
  end

  def create
     shelter = Shelter.find(params[:shelter_id])
     review = shelter.reviews.create(review_params)
     redirect_to("/shelters/#{shelter.id}/reviews")
   end

   def show
     @shelter = Shelter.find(params[:shelter_id])
   end

   private
   def review_params
     params.permit(:title, :rating, :content, :optional_picture)
   end
end
