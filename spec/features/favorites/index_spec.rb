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

  it " There is a '/favorites' index page, and Favorite pets are listed there" do
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

  it "Displays pet's image and pet's name is a link to pet's show page" do
    visit "/pets/#{@pet_1.id}"
    click_on "Favorite"
    @pet_1.reload
    visit "/pets"
    save_and_open_page
    expect(page).to have_content("Favorite 3")
    expect(page).to have_selector(:link_or_button, 'Favorite')
    expect(page).to have_xpath("//img['brown_puppy.jpg']")
  end
end