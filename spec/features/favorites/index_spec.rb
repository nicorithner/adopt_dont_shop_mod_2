require 'rails_helper'

RSpec.describe "pets index page" do

  before :each do
    @shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
    @shelter_2 = Shelter.create!(name: "Shelter 2", address: "123 road", city: "Denver", state: "CO", zip: 80201)

    @pet_1 = Pet.create!(image: "brown_puppy.jpg", name: "Puppy1", age: 1, sex: "Male", shelter_id: @shelter_1.id, favorite: "false")
    @pet_2 = Pet.create!(image: "english_bulldog.jpg", name: "Puppy2", age: 1, sex: "Female", shelter_id: @shelter_1.id, favorite: "true")
    @pet_3 = Pet.create!(image: "golden.jpg", name: "Puppy3", age: 2, sex: "Female", shelter_id: @shelter_2.id, favorite: "true")
    @pet_4 = Pet.create!(image: "cat.jpg", name: "Kitten1", age: 2, sex: "Male", shelter_id: @shelter_2.id, favorite: "false")
  end

  describe " There is a '/favorites' index page, and Favorite pets are listed there" do
    
    it "Pets are listed at '/favorites'" do
      visit "/favorites"
      expect(current_path).to eq("/favorites")
      expect(page).to have_content("Puppy2")
      expect(page).to have_content("Puppy3")
    end

    it "Displays pet's image and pet's name is a link to pet's show page" do
      visit "/favorites"
      expect(page).to have_selector(:link_or_button, 'Puppy2')
      expect(page).to have_xpath("//img['brown_puppy.jpg']")
    end

    it "Favorites pets count is incremented after clicking 'Favorite'" do
      visit "/pets/#{@pet_1.id}"
      click_on "Favorite"
      @pet_1.reload
      visit "/pets"
      expect(page).to have_content("Favorite 3")
    end
  end


  describe "Remove a Favorite from Favorites page" do

    it "There is a 'Remove Favorite' link next to each pet in Favorites index page" do
      visit "/favorites"
      within("#pet-#{@pet_2.id}") do
        expect(page).to have_link("Remove Favorite")
      end
    end

    it "Clicking 'Remove Favorite' toggles ':favorite' to false, visitor remains in Favorites page" do
      visit "/favorites"
      expect(page).to have_content("Puppy2")
      expect(page).to have_content("Puppy3")

      within("#pet-#{@pet_2.id}") do
        click_link "Remove Favorite"
      end

      visit "/favorites"
      expect(page).to have_content("Puppy3")
      expect(page).to_not have_content("Puppy2")

      
    end

    it "Favorite count in nav bar is updated after clicking 'Remove Favorite' link" do
      visit "/favorites"
      expect(page).to have_content("Puppy2")
      expect(page).to have_content("Puppy3")

      within("#pet-#{@pet_2.id}") do
        click_link "Remove Favorite"
      end

      within '.topnav' do
        expect(page).to have_content("Favorite 1")
      end
    end
  end

  describe "If there are No Favorites in Favorites page there is a message saying so " do
    it "displays 'no favorites' message" do
      visit "/favorites"
      expect(page).to have_content("Puppy2")
      expect(page).to have_content("Puppy3")

      within("#pet-#{@pet_2.id}") do
        click_link "Remove Favorite"
      end

      visit "/favorites"
      expect(page).to_not have_content("Puppy2")

      within("#pet-#{@pet_3.id}") do
        click_link "Remove Favorite"
      end

      visit "/favorites"
      expect(page).to_not have_content("Puppy3")
      expect(page).to have_content("You haven't favorited any pets")
    end
  end

  describe "A 'Remove All Favorites' link removes all pets from favorites once clicked. This displays a message that no pets have been favorited and reduces favorites count to zero" do
    it "'Remove All Favorites' link function" do
      visit "/favorites"
      expect(page).to have_content("Puppy2")
      expect(page).to have_content("Puppy3")
      expect(page).to have_link("Remove All Favorites")

      click_link "Remove All Favorites"
      
      visit "/favorites"

      expect(page).to_not have_content("Puppy2")
      expect(page).to_not have_content("Puppy3")
      expect(page).to have_content("You haven't favorited any pets")

      within '.topnav' do
        expect(page).to have_content("Favorite 0")
      end
    end
  end
end