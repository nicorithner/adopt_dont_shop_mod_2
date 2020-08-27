class Pet < ApplicationRecord
  validates_presence_of :image, :name, :age, :sex, :shelter, favorite: false

  belongs_to :shelter

  def self.favorites
    Pet.where(favorite: "true").count
  end
  
  def self.total_favorites
    Pet.where(favorite: "true")
  end
    
end