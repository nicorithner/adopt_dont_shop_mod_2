require 'rails_helper'

RSpec.describe "pets index page" do

  before :each do
    @shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
    @shelter_2 = Shelter.create!(name: "Shelter 2", address: "123 road", city: "Denver", state: "CO", zip: 80201)

    @pet_1 = Pet.create!(image: "brown_puppy.jpg", name: "Puppy1", age: 1, sex: "Male", shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(image: "english_bulldog.jpg", name: "Puppy2", age: 1, sex: "Female", shelter_id: @shelter_1.id)
    @pet_3 = Pet.create!(image: "golden.jpg", name: "Puppy3", age: 2, sex: "Female", shelter_id: @shelter_2.id)
    @pet_4 = Pet.create!(image: "cat.jpg", name: "Kitten1", age: 2, sex: "Male", shelter_id: @shelter_2.id)
  end

  it "Can see each pet in the system info" do
    visit "/pets"

    expect(page).to have_xpath("//img['brown_puppy.jpg']")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.age)
    expect(page).to have_content(@pet_1.sex)
    expect(page).to have_content(@pet_1.shelter.name)
  end

  it "Can Update Pet From Pet Index Page" do

    visit "/shelters/#{@shelter_1.id}/pets"
    expect(page).to have_selector(:link_or_button, "Edit #{@pet_1.name}")

    click_on "Edit #{@pet_1.name}"
    expect(current_path).to eq("/pets/#{@pet_1.id}/edit")

    fill_in :name, with: "New name"

    click_on "Update Pet"
    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to_not have_content("Edit #{@pet_1.name}")
    expect(page).to have_content("New name")
  end

  it "It can Delete Pet From Pet's Index Page" do

    visit "/shelters/#{@shelter_1.id}/pets"
    expect(page).to have_content("Delete #{@pet_1.name}")
    expect(page).to have_content("Delete #{@pet_2.name}")

    click_on "Delete #{@pet_2.name}"
    expect(current_path).to eq("/pets")
    expect(page).to have_content("Delete #{@pet_1.name}")
    expect(page).to_not have_content("Delete #{@pet_2.name}")
  end

end