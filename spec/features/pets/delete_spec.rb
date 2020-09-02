require "rails_helper"

RSpec.describe "Pet Delete" do

  it "can delete a pet" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 lane", city: "Denver", state: "CO", zip: 80202)
    pet_1 = Pet.create!(image: "frog.jpg", name: "Toby", age: 1, sex: "Male", shelter: shelter_1)

    visit "/pets/#{pet_1.id}"
    expect(page).to have_selector(:link_or_button, 'Delete Pet')

    expect(page).to have_content("#{pet_1.name}")
    click_on "Delete Pet"

    expect(current_path).to eq("/pets")
    expect(page).to_not have_content("#{pet_1.name}")
  end

  it "can't delete a pet with application pending" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 lane", city: "Denver", state: "CO", zip: 80202)
    pet_1 = Pet.create!(image: "frog.jpg", name: "Toby", age: 1, sex: "Male", shelter: shelter_1, application_pending: true)

    visit "/pets/#{pet_1.id}"
    expect(page).to_not have_selector(:link_or_button, 'Delete Pet')

  end

end
