class AppController < ApplicationController

  def create
     @application = App.new(app_params)
     @pets = Pet.all
     if @application.save
       redirect_to("/favorites")
     else
       flash[:notice] = "Application not submitted: Required information missing"
       redirect_to("/favorites/:id/adopt")
     end
   end

   private
   def app_params
     params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
   end
end
