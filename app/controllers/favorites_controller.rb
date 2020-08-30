class FavoritesController < ApplicationController
  def index
    @favorites = FavoritePet.new(session[:favorite])
    @favorites.favorites
  end
end