require 'rails_helper'

RSpec.describe "pets index page" do

  before :each do
    @shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
    @shelter_2 = Shelter.create!(name: "Shelter 2", address: "123 road", city: "Denver", state: "CO", zip: 80201)

    @pet_1 = Pet.create!(image: "brown_puppy.jpg", name: "Puppy1", age: 1, sex: "Male", shelter_id: @shelter_1.id, status: "adoptable", description: "Cute brown puppy")
    @pet_2 = Pet.create!(image: "english_bulldog.jpg", name: "Puppy2", age: 1, sex: "Female", shelter_id: @shelter_1.id, status: "pending", description: "Chubby english bulldog puppy")
    @pet_3 = Pet.create!(image: "golden.jpg", name: "Puppy3", age: 2, sex: "Female", shelter_id: @shelter_2.id, status: "adoptable", description: "Sweet and full of energy golden retriever")
    @pet_4 = Pet.create!(image: "cat.jpg", name: "Kitten1", age: 2, sex: "Male", shelter_id: @shelter_2.id, status: "pending", description: "Aloof Siamese cat")
  end


  it "Can see each pet info in '/pets/:id'" do
    visit "/pets/#{@pet_1.id}"

    expect(page).to have_xpath("//img['brown_puppy.jpg']")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.age)
    expect(page).to have_content(@pet_1.sex)
    expect(page).to have_content("#{@pet_1.status}")
    expect(page).to have_content("#{@pet_1.description}")
  end
  end