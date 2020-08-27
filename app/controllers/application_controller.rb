class ApplicationController < ActionController::Base
  helper_method :favorite

  def favorite
    @pets = Pet.favorites
  end

  def create
    application = Application.new(app_params)
    if application.save
      redirect_to("/favorites")
    else
      flash[:notice] = "Review not created: Required information missing"
      render :new
    end
  end

  private
  def app_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
