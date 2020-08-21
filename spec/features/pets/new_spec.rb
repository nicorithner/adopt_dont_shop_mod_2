require 'rails_helper'

RSpec.describe "pets index page" do

  before :each do
    @shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
  end


  it "From Shelter Pets Index. 'Create Pet' link routes to '/shelters/:shelter_id/pets/new'" do
    visit "/shelters/#{@shelter_1.id}/pets"
    expect(page).to have_selector(:link_or_button, 'Create Pet')

    click_on "Create Pet"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")
  end

  it "Can create a new adoptable pet and see it in shelter's index page" do
    visit "/shelters/#{@shelter_1.id}/pets/new"

    fill_in :image, with: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg"
    fill_in :name, with: "Snowy"
    fill_in :age, with: 1
    fill_in :sex, with: "Female"
    fill_in :description, with: "Fun and loving, high energy puppy"

    click_on "Create Pet"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")

    expect(page).to have_content("Snowy")
    expect(page).to have_content("Available")
  end

end