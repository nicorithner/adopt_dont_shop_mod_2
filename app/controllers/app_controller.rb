class AppController < ApplicationController

  def create
    ActiveRecord::Base.transaction do #for db stuff only, keep redirect out
      app = App.create!(name: app_params[:name], address: app_params[:address], city: app_params[:city], state: app_params[:state], zip: app_params[:zip], phone_number: app_params[:phone_number], description: app_params[:description])
      ids = app_params[:pets]
      pets = Pet.where(id: ids)
      # pet = Pet.where(id: (ids.map{ |id| id}))

      pets.each do |pet|
        ApplicationPet.create!(app_id: app.id, pet_id: pet.id)
        pet.update!(favorite: false, application_pending: true)
        # require "pry"; binding.pry
      end
    end
    # pets.each{ |pet| pet.update(application_pending: true)}
    redirect_to("/favorites")
  rescue => error #add more sad path testing, pet doesn't exist, etc. Make sure redirect works
    flash[:notice] = "Application not submitted: Required information missing"
    redirect_to("/favorites/adopt")
  end

  def index
    @app = App.all
  end

  def show
    @app = App.find(params[:id])
  end

  def show_apps
    @app = Pet.find(params[:id]).apps
  end

  def toggle_status
    pet = Pet.find(params[:id])
    pet.update(status: "pending")
    if pet.status == "pending"
      flash[:notice] = "Application approved"
      redirect_to("/pets/#{pet.id}")
    else
      flash[:notice] = "Application not approved"
    end
  end

  private
  def app_params
    params.permit(:name, :address, :city,
      :state, :zip, :phone_number, :description, :pets => [])
    end
  end
