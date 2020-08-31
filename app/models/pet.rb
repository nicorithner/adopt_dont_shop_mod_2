class Pet < ApplicationRecord
  validates_presence_of :image, :name, :age, :sex, :shelter, favorite: false
  
  belongs_to :shelter
  has_many :application_pets
  has_many :apps, through: :application_pets
end
