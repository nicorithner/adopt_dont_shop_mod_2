class PetsController < ApplicationController
  def index
    @pets = ['pet 1', 'pet 2', 'pet 3']
  end
end
