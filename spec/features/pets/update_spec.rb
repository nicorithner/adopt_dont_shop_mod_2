require "rails_helper"

RSpec.describe "Pet Update" do

  it "can update pet info" do

    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "Cool_horse.jpg", name: "Seth", age: 3, sex: "Male", description: "Full of energy and it's always ready to go for a ride",shelter_id: shelter_1.id)

    visit "/pets/#{pet_1.id}"
    expect(page).to have_content("Seth")

    click_on "Update Pet"
    expect(current_path).to eq("/pets/#{pet_1.id}/edit")

    fill_in :name, with: "Tony"

    click_button "Update Pet"
    expect(current_path).to eq("/pets/#{pet_1.id}")

    expect(page).to_not have_content("Seth")
    expect(page).to have_content("Tony")
  end
end