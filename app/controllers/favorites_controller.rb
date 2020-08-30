class FavoritesController < ApplicationController
  def index
    @favorites = FavoritePet.new(session[:favorite])
    @favorites.favorites
  end

  def add_favorite
    @pet = Pet.find(params[:id])
    @favorites = FavoritePet.new(session[:favorite])
    @favorites.add_pet(@pet)
    redirect_to("/pets/#{@pet.id}")

    if @favorites.favorited?(@pet)
      flash[:notice] = "Pet saved to favorites"
    else
      flash[:notice] = "Pet Removed from favorites"
    end
  end

  #===Needs to be refactor
  # def remove_all_favorites
  # @pets = Pet.all
  # @pets.total_favorites.map {|pet| pet.update(favorite: !pet.favorite)}
  # end
end