class Pet < ApplicationRecord
  validates_presence_of :image, :name, :age, :sex, :shelter, favorite: false

  belongs_to :shelter    
end