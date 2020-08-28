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

      click_on "Adopt Pets"

      expect(current_path).to eq("/favorites/adopt")


      within("#pets_") do
        check
      end

      fill_in :name, with: "George McFly"
      fill_in :address, with: '2778 South Yup St'
      fill_in :city, with: "Lakewood"
      fill_in :state, with: "CO"
      fill_in :zip, with: 87769
      fill_in :phone_number, with: 7205567890
      fill_in :description, with: "here's a photo"

      click_on "Adopt!"
      expect(current_path).to eq("/favorites")
  end

  it "When I apply for a pet and fail to fill out any of the fields I'm redirected back to new application with a flash message" do
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

    click_on "Adopt Pets"

    expect(current_path).to eq("/favorites/adopt")


    within("#pets_") do
      check
    end

    fill_in :name, with: ""
    fill_in :address, with: '2778 South Yup St'
    fill_in :city, with: "Lakewood"
    fill_in :state, with: "CO"
    fill_in :zip, with: 87769
    fill_in :phone_number, with: 7205567890
    fill_in :description, with: "here's a photo"

    click_on "Adopt!"
    expect(page).to have_content("Application not submitted: Required information missing")
  end

  it "And I'm taken back to my favorites page where I no longer see the pets for which I just applied listed as favorites" do
    visit "/pets/#{@pet_1.id}"

    expect(@pet_1[:favorite]).to be_in([false])

    click_on "Favorite"
    @pet_1.reload

    visit "/favorites/adopt"

    fill_in :name, with: "Bob"
    fill_in :address, with: '2778 South Yup St'
    fill_in :city, with: "Lakewood"
    fill_in :state, with: "CO"
    fill_in :zip, with: 87769
    fill_in :phone_number, with: 7205567890
    fill_in :description, with: "here's a photo"

      click_on 'Adopt!'
      expect(current_path).to eq("/favorites")
      expect(page).not_to have_content("#{@pet_1.name}")

  end

end
