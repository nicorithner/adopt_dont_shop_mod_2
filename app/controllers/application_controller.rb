class ApplicationController < ActionController::Base
  helper_method :favorites_count, :session_favorites

  def session_favorites
    return session[:favorites] if session[:favorites]
    return session[:favorites] = [] if session[:favorites].nil?
  end

  def favorites_count
    session_favorites.count
  end
end
