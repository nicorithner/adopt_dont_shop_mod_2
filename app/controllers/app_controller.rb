class AppController < ApplicationController

  def create
     @application = App.new(app_params)
     ids = params[:id]
     pet = Pet.where(params[:id] = ids)
     if @application.save
       pet.each{ |pet| pet.update(favorite: !pet.favorite)}
       redirect_to("/favorites")
     else
       flash[:notice] = "Application not submitted: Required information missing"
       redirect_to("/favorites/adopt")
     end
   end

   private
   def app_params
     params.permit(:name, :address, :city, :state, :zip, :phone_number, :description, :pets)
   end
end
