class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    empty = pet_params.select{ |k,v| v == ""}.keys[0]
    if empty.nil?
      pet = shelter.pets.create(pet_params)
      redirect_to("/shelters/#{shelter.id}/pets")
    else
      flash[:error] = "Application incomplete: please include #{empty}"
      redirect_to("/shelters/#{shelter.id}/pets/new")
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    redirect_to("/pets/#{pet.id}")
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to "/pets"
  end

  def adopt
    @favorites = session_favorites
  end

  private
  def pet_params
    params.permit(:image, :name, :age, :sex, :description, :status, :shelter_id, :favorite)
  end

end
