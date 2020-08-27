class AppController < ApplicationController

  def create
     @application = App.new(app_params)
     @application.save
     # if review.save
       redirect_to("/favorites")
     # else
     #   flash[:notice] = "Review not created: Required information missing"
     #   render :new
     # end
   end

   private
   def app_params
     params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
   end
end
