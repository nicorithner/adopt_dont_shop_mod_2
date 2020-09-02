require 'rails_helper'

RSpec.describe "pets index page" do

  before :each do
    @shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
    @shelter_2 = Shelter.create!(name: "Shelter 2", address: "777 st", city: "Lakewood", state: "UT", zip: 99765)

    @pet_1 = Pet.create!(image: "frog.jpg", name: "Toby", age: 1, sex: "Male", shelter: @shelter_1)
    @pet_2 = Pet.create!(image: "frog.jpg", name: "Lionel", age: 2, sex: "Female", shelter: @shelter_2)


  end
end
