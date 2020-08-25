class Pet < ApplicationRecord
  validates_presence_of :image, :name, :age, :sex, :shelter

  belongs_to :shelter

  def self.favorites
    Pet.where(favorite: "true").count
  end
end