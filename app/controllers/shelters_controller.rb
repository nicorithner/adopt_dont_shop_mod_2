class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new
  end

  def create #change this?
    shelter = Shelter.new({
      name: params[:shelter][:name],
      address: params[:shelter][:address],
      city: params[:shelter][:city],
      state: params[:shelter][:state],
      zip: params[:shelter][:zip]
      })

    if shelter.save
      redirect_to '/shelters'
    else
      flash[:error] = "Incomplete form."
      redirect_to request.referrer
    end
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    if shelter.update(shelter_params)
      redirect_to("/shelters/#{shelter.id}")
    else
      flash[:error] = "Incomplete form."
      redirect_to request.referrer
    end
  end

  def destroy
    reviews = Shelter.find(params[:id]).reviews
    if reviews.empty?
      Shelter.destroy(params[:id])
      redirect_to '/shelters'
    else
      reviews.each do |review|
        Review.destroy(review.id)
      end
      Shelter.destroy(params[:id])
      redirect_to '/shelters'
    end
  end

  def pets_index
    @shelter = Shelter.find(params["shelter_id"]).pets
    @shelter_id = Shelter.find(params["shelter_id"]).id
    @shelter_name = Shelter.find(params["shelter_id"]).name
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip, :reviews)
  end
end
