class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
  end

   def create
    shelter = Shelter.find(params[:shelter_id])
    pet = shelter.pets.create(pet_params)

    pet.save
    redirect_to("/shelters/#{shelter.id}/pets")
  end
end
