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
      pet = shelter.pets.create(pet_params)
      redirect_to("/shelters/#{shelter.id}/pets")
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

  def toogle_favorite
    @pet = Pet.find(params[:id])
    @pet.update(favorite: !@pet.favorite)
    redirect_to("/pets/#{@pet.id}")
    if @pet.favorite
      flash[:notice] = "Pet saved to favorites"
    else
      flash[:notice] = "Pet Removed from favorites"
    end
    # render :new
  end

  def adopt
    @favorites = Pet.where(favorite: "true")

  def remove_all_favorites
    @pets = Pet.all
    @pets.total_favorites.map {|pet| pet.update(favorite: !pet.favorite)}
  end

  private
  def pet_params
    params.permit(:image, :name, :age, :sex, :description, :status, :shelter_id, :favorite)
  end

end
