require 'rails_helper'

RSpec.describe "Apply for pet" do

  before :each do
    @shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
    @shelter_2 = Shelter.create!(name: "Shelter 2", address: "123 road", city: "Denver", state: "CO", zip: 80201)

    @pet_1 = Pet.create!(image: "brown_puppy.jpg", name: "Puppy1", age: 1, sex: "Male", shelter_id: @shelter_1.id, favorite: "false")
  end

  it "When I have added pets to my favorites list" do
      visit "/pets/#{@pet_1.id}"

      expect(@pet_1[:favorite]).to be_in([false])

      click_on "Favorite"
      @pet_1.reload

      expect(current_path).to eq("/pets/#{@pet_1.id}")
      expect(@pet_1[:favorite]).to be_in([true])
      expect(@pet_1.favorite).to eq(true)
      expect(page).to have_content("Pet saved to favorites")

      visit "/favorites"
      expect(page).to have_content("Puppy1")

      click_on "Adopt #{@pet_1.name}"

      expect(current_path).to eq("/pets/#{@pet_1.id}/adopt")


      within("##{@pet_1.name}") do
        choose('adopt')
      end

      fill_in :name, with: "Good, not great"
      fill_in :address, with: 3
      fill_in :city, with: "It was alright, we weren't impressed."
      fill_in :state, with: "here's a photo"
      fill_in :zip, with: "here's a photo"
      fill_in :phone_number, with: "here's a photo"
      fill_in :description, with: "here's a photo"

      click_on "Submit Application"
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews")

  end

end
