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

  describe "Nav bar favorite features" do

    it "favorite indicator in the nav bar" do
      visit "/pets"
      expect(page).to have_content("Favorite")
      expect(@pet_1[:favorite]).to be_in([false])
    end

    it "Favorite indicator shows count of fav pets" do
      visit "/pets"
      expect(page).to have_content("Favorite 2")
    end
  end

  describe "Favorite toggle link in pet's show page" do

    it "It has favorite link" do
      visit "/pets/#{@pet_1.id}"
      expect(page).to have_selector(:link_or_button, 'Favorite')
    end

    it "Clicking favorite link toggles to true, visitor remains in show page and there is a flash message confirming action" do
      visit "/pets/#{@pet_1.id}"
      expect(@pet_1[:favorite]).to be_in([false])
      click_on "Favorite"
      @pet_1.reload
      expect(current_path).to eq("/pets/#{@pet_1.id}")
      expect(@pet_1[:favorite]).to be_in([true])
      expect(page).to have_content("Pet saved to favorites")
    end

    it "Favorite count in nav bar is updated after clicking fav link" do
      visit "/pets/#{@pet_1.id}"
      click_on "Favorite"
      @pet_1.reload
      visit "/pets"
      expect(page).to have_content("Favorite 3")
    end
  end

  describe " When a pet is favorited, in pet's show page there's a 'Remove Favorite' link and not 'Favorite' link" do

    it "It has 'Remove Favorite' link" do
      visit "/pets/#{@pet_1.id}"
      click_on "Favorite"
      @pet_1.reload
      
      expect(page).to have_selector(:link_or_button, "Remove Favorite")
      within '.links' do
      expect(page).to_not have_button("Favorite")
      end
    end

    # it "Clicking 'Remove Favorite' link toggles ':favorite' to false, visitor remains in show page and there is a flash message confirming action" do
    #   visit "/pets/#{@pet_1.id}"
    #   expect(@pet_1[:favorite]).to be_in([true])

    #   click_on "Remove Favorite"
    #   @pet_1.reload
    #   expect(current_path).to eq("/pets/#{@pet_1.id}")
    #   expect(@pet_1[:favorite]).to be_in([false])
    #   expect(page).to have_content("Pet Removed from favorites")

    #   expect(page).to have_selector(:link_or_button, 'Favorite')
    # end

    # it "Favorite count in nav bar is updated after clicking 'Remove Favorite' link" do
    #   visit "/pets/#{@pet_1.id}"
    #   click_on "Remove Favorite"
    #   @pet_1.reload

    #   visit "/pets"
    #   # expect(page).to have_content("Favorite 2") ## Try the within test first
    #   within(".topnav") do
    #     expect(page).to have_content("Favorites: 2")
    #   end
    # end
  end

end