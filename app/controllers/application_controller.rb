class ApplicationController < ActionController::Base
  helper_method :favorites

  def favorites
    @favorites = FavoritePet.new(session[:favorite])
    # binding.pry
    @favorites.favorites_count
  end
end
