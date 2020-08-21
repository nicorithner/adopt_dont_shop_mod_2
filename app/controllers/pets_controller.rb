class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
  end

   def create
    pet = Pet.new({
      image: params[:pet][:name],
      name: params[:pet][:name],
      age: params[:pet][:age],
      sex: params[:pet][:sex],
      description: params[:pet][:description],
      status: params[:pet][:status]
      })

    pet.save
    redirect_to '/pets'
  end
end
