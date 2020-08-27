class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new
  end

  def create
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
    shelter.update(shelter_params)
    redirect_to("/shelters/#{shelter.id}")
  end

  def destroy
  Shelter.destroy(params[:id])
  redirect_to '/shelters'
  end

  def pets_index
    @shelter = Shelter.find(params["shelter_id"]).pets
    @shelter_id = Shelter.find(params["shelter_id"]).id
    @shelter_name = Shelter.find(params["shelter_id"]).name
  end

  private
  
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end