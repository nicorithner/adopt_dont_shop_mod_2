class FavoritesController < ApplicationController

  def index
    # @favorites = session_favorites
     @favorites = Pet.where(favorite: "true")
    @pets = Pet.where(application_pending: "true")
  end

  def add_favorite
    @pet = Pet.find(params[:id])
    session_favorites << @pet
    redirect_to("/pets/#{@pet.id}")

    if session_favorites.include?(@pet)
      flash[:notice] = "Pet saved to favorites"
    else
      flash[:notice] = "Pet Removed from favorites"
    end
  end

  def show
    @favorites = Pet.where(favorite: true)
  end

  def remove_favorite
    pet = Pet.find(params[:id])
    session_favorites.delete(session_favorites.find {|p| pet})
    redirect_to("/favorites")
  end

  def remove_all_favorites
    session_favorites.clear
  end
end
