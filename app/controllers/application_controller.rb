class ApplicationController < ActionController::Base
  helper_method :favorite

  def favorite
    @pets = Pet.favorites
  end
end
