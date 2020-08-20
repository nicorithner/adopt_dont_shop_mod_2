require 'rails_helper'

RSpec.describe "pets index page" do

  before :each do
    @shelter_1 = Shelter.create(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
    @shelter_2 = Shelter.create(name: "Shelter 2", address: "123 road", city: "Denver", state: "CO", zip: 80201)

    @pet_1 = Pet.create(image: "https://pixabay.com/images/id-1284307/", name: "Puppy1", age: 1, sex: "Male", shelter: @shelter_1)
    @pet_2 = Pet.create(image: "https://pixabay.com/images/id-5422018/", name: "Puppy2", age: 1, sex: "Female", shelter: @shelter_1)
    @pet_3 = Pet.create(image: "https://pixabay.com/images/id-4292254/", name: "Puppy3", age: 2, sex: "Female", shelter: @shelter_2)
    @pet_4 = Pet.create(image: "https://pixabay.com/images/id-2068462/", name: "Kitten1", age: 2, sex: "Male", shelter: @shelter_2)
  end

  # it "Can see each pet in the system with its info when visits '/pets/" do
  #   visit "/pets"

  #   expect(page).to have_xpath("//img[@src='https://pixabay.com/images/id-1284307/' and @alt='Puppy1']")
  #   expect(page).to have_content(pet_1.name)
  #   expect(page).to have_content(pet_1.age)
  #   expect(page).to have_content(pet_1.sex)
  #   expect(page).to have_content(pet_1.shelter.name)
  # end

end