require 'rails_helper'

RSpec.describe "pets index page" do

  before :each do
    @shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
    @shelter_2 = Shelter.create!(name: "Shelter 2", address: "123 road", city: "Denver", state: "CO", zip: 80201)

    @pet_1 = Pet.create!(image: "brown_puppy.jpg", name: "Puppy1", age: 1, sex: "Male", shelter_id: @shelter_1.id, favorite: "false")
    @pet_2 = Pet.create!(image: "english_bulldog.jpg", name: "Puppy2", age: 1, sex: "Female", shelter_id: @shelter_1.id, favorite: "false")
    @pet_3 = Pet.create!(image: "golden.jpg", name: "Puppy3", age: 2, sex: "Female", shelter_id: @shelter_2.id, favorite: "false")
    @pet_4 = Pet.create!(image: "cat.jpg", name: "Kitten1", age: 2, sex: "Male", shelter_id: @shelter_2.id, favorite: "false")
  end

  it "favorite indicator in the nav bar" do
    visit "/pets"

    expect(page).to have_content("Favorite")
    expect(@pet_1[:favorite]).to be_in([false])
  end

  it "Favorite indicator shows count of fav pets" do
    
  end

end