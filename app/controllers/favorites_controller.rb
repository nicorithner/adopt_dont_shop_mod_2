class FavoritesController < ApplicationController
  def index
    @favorites = Favorite_pet.new(session[:favorite])
    @favorites.all
  end
end