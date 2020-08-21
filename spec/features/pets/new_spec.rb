require 'rails_helper'

RSpec.describe "pets index page" do

  before :each do
    @shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
    @shelter_2 = Shelter.create!(name: "Shelter 2", address: "123 road", city: "Denver", state: "CO", zip: 80201)

    @pet_1 = Pet.create!(image: "brown_puppy.jpg", name: "Puppy1", age: 1, sex: "Male", shelter_id: @shelter_1.id, status: "adoptable", description: "Cute brown puppy")
    @pet_2 = Pet.create!(image: "english_bulldog.jpg", name: "Puppy2", age: 1, sex: "Female", shelter_id: @shelter_1.id, status: "pending", description: "Chubby english bulldog puppy")
    @pet_3 = Pet.create!(image: "golden.jpg", name: "Puppy3", age: 2, sex: "Female", shelter_id: @shelter_2.id, status: "adoptable", description: "Sweet and full of energy golden retriever")
    @pet_4 = Pet.create!(image: "cat.jpg", name: "Kitten1", age: 2, sex: "Male", shelter_id: @shelter_2.id, status: "pending", description: "Aloof Siamese cat")
  end


  it "From Shelter Pets Index. 'Create Pet' link routes to '/shelters/:shelter_id/pets/new'" do
    visit "/shelters/#{@shelter_1.id}/pets"
    expect(page).to have_selector(:link_or_button, 'Create Pet')

    click_on "Create Pet"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")
  end

  it "Can create a new adoptable pet and see it in shelter's index page" do
    visit "/shelters/#{@shelter_1.id}/pets/new"

    fill_in 'pet[image]', with: "white_puppy.jpg"
    fill_in 'pet[name]', with: "Snowy"
    fill_in 'pet[age]', with: 1
    fill_in 'pet[sex]', with: "Female"
    fill_in 'pet[description]', with: "Fun and loving, high energy puppy"

    click_on "Create Pet"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")

    expect(page).to have_content("Snowy")
    expect(page).to have_content("Adoptable")
  end

end