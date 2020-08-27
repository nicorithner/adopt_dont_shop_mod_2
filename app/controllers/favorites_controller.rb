class FavoritesController < ApplicationController
  def index
    @favorites = Pet.where(favorite: "true")
  end

end