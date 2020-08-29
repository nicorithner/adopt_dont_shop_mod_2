class FavoritesController < ApplicationController
  def index
    @favorites = Pet.where(favorite: "true")
    @pets = Pet.where(application_pending: "true")
  end

end
