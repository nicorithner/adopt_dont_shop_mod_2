require 'rails_helper'

RSpec.describe "Apply for pet" do

  before :each do
    @shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
    @shelter_2 = Shelter.create!(name: "Shelter 2", address: "123 road", city: "Denver", state: "CO", zip: 80201)

    @pet_1 = Pet.create!(image: "brown_puppy.jpg", name: "Puppy1", age: 1, sex: "Male", shelter_id: @shelter_1.id, favorite: false, application_pending: false)
    @pet_2 = Pet.create(image: "english_bulldog.jpg", name: "Puppy2", age: 1, sex: "Female", shelter_id: @shelter_1.id, favorite: false, application_pending: false)
    @pet_3 = Pet.create(image: "golden.jpg", name: "Puppy3", age: 2, sex: "Female", shelter_id: @shelter_2.id, favorite: false, application_pending: false)
    @pet_4 = Pet.create(image: "cat.jpg", name: "Kitten1", age: 2, sex: "Male", shelter_id: @shelter_2.id, favorite: false, application_pending: false)
    @pet_5 = Pet.create(image: "cat.jpg", name: "Kitten2", age: 20, sex: "Male", shelter_id: @shelter_2.id, favorite: true, application_pending: false)

  end

  it "When I have added pets to my favorites list" do

    visit "/favorites"
    expect(page).to have_content("#{@pet_5.name}")

    click_on "Adopt Pets"

    expect(current_path).to eq("/pets/#{@pet_5.id}/adopt")


    within("##{@pet_5.id}") do
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
    visit "/favorites"
    expect(page).to have_content("#{@pet_5.name}")

    click_on "Adopt Pets"

    expect(current_path).to eq("/pets/#{@pet_5.id}/adopt")


    within("#pets_") do
      check
    end

    fill_in :address, with: "2778 South Yup St"
    fill_in :city, with: "Lakewood"
    fill_in :state, with: "CO"
    fill_in :zip, with: 87769
    fill_in :phone_number, with: 7205567890
    fill_in :description, with: "here's a photo"

    click_on "Adopt!"
    expect(page).to have_content("Application not submitted: Required information missing")
  end

  it "And I'm taken back to my favorites page where I no longer see the pets for which I just applied listed as favorites" do
    visit "/favorites"
    expect(page).to have_content("#{@pet_5.name}")

    click_on "Adopt Pets"

    expect(current_path).to eq("/pets/#{@pet_5.id}/adopt")


    within("#pets_") do
      check
    end

    fill_in :name, with: "Bob"
    fill_in :address, with: '2778 South Yup St'
    fill_in :city, with: "Lakewood"
    fill_in :state, with: "CO"
    fill_in :zip, with: 87769
    fill_in :phone_number, with: 7205567890
    fill_in :description, with: "here's a photo"

    click_on 'Adopt!'
    expect(current_path).to eq("/favorites")
    # expect(page).not_to have_content("#{@pet_5.name}")
  end

  describe "After one or more applications have been created" do
    it "When I visit favorites index page I see a section on the page that has a list of all pets have have at least one application on them" do

      visit "/pets/#{@pet_5.id}/adopt"

      within("#pets_") do
        check
      end

      fill_in :name, with: "Bob"
      fill_in :address, with: '2778 South Yup St'
      fill_in :city, with: "Lakewood"
      fill_in :state, with: "CO"
      fill_in :zip, with: 87769
      fill_in :phone_number, with: 7205567890
      fill_in :description, with: "here's a photo"

      click_on 'Adopt!'
      visit "/favorites"
      expect(page).to have_content("Applications pending for:\n#{@pet_5.name}")

    end
  end
end
