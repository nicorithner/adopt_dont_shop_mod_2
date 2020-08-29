class ApplicationController < ActionController::Base
  helper_method :favorites

  def favorites
    @favorites = FavoritePet.new(session[:favorite])
    @favorites.favorites_count
  end
end
