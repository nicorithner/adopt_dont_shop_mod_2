class App < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :phone_number, :description

  # belongs_to :pet
end
