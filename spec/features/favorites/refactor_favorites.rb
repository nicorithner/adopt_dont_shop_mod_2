require 'rails_helper'

RSpec.describe "pets index page" do

  before :each do
    @shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
    @shelter_2 = Shelter.create!(name: "Shelter 2", address: "123 road", city: "Denver", state: "CO", zip: 80201)
  
    @pet_1 = @shelter_1.pets.create!(image: "brown_puppy.jpg", name: "Puppy1", age: 1, sex: "Male")
    @pet_2 = Pet.create!(image: "english_bulldog.jpg", name: "Puppy2", age: 1, sex: "Female", shelter_id: @shelter_1.id)
    @pet_3 = Pet.create!(image: "golden.jpg", name: "Puppy3", age: 2, sex: "Female", shelter_id: @shelter_2.id)
    @pet_4 = Pet.create!(image: "cat.jpg", name: "Kitten1", age: 2, sex: "Male", shelter_id: @shelter_2.id)
  end

  describe "Nav bar favorite features" do

    it "favorite indicator in the nav bar" do
      visit "/pets"
      expect(page).to have_content("Favorite")
    end

    it "Favorite indicator shows count of fav pets" do
      visit "/"
      within '.topnav' do
      expect(page).to have_content("Favorite 0")
      end
    end
  end

  describe "Favorite toggle link in pet's show page" do

    it "It has favorite link" do
      visit "/pets/#{@pet_1.id}"
      expect(page).to have_selector(:link_or_button, 'Favorite')
    end

    it "Visting Favorites index if empty a there is a message saying there are no favorited pets" do
      visit "/favorites"
      expect(page).to_not have_content("#{@pet_1.name}")
    end

    it "Clicking favorite adds pet to favorites, visitor remains in show page and there is a flash message confirming action" do
      visit "/pets/#{@pet_1.id}"
      click_on "Favorite"
      expect(page).to have_content("Pet saved to favorites")
      expect(current_path).to eq("/pets/#{@pet_1.id}")

      visit "/favorites"
      expect(page).to have_content("#{@pet_1.name}")
    end 

    it "Favorite count in nav bar is updated after clicking fav link" do
      visit "/pets/#{@pet_1.id}"
      click_on "Favorite"
      @pet_1.reload
      visit "/pets"
      expect(page).to have_content("Favorite 1")
    end
  end

  describe " There is a '/favorites' index page, and Favorite pets are listed there" do
    
    it "Pets are listed at '/favorites'" do
      visit "/pets/#{@pet_2.id}"
      click_on "Favorite"
      visit "/pets/#{@pet_3.id}"
      click_on "Favorite"

      visit "/favorites"
      expect(current_path).to eq("/favorites")
      expect(page).to have_content("Puppy2")
      expect(page).to have_content("Puppy3")
    end

    it "Displays pet's image and pet's name is a link to pet's show page" do
      visit "/pets/#{@pet_2.id}"
      click_on "Favorite"
      visit "/favorites"

      expect(page).to have_selector(:link_or_button, 'Puppy2')
      expect(page).to have_xpath("//img['brown_puppy.jpg']")
    end
  end
end