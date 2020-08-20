# User Story 9, Pet Show

# As a visitor
# When I visit '/pets/:id'
#       Then I see the pet with that id including the pet's:
                    # - image
                    # - name
                    # - description
                    # - approximate age
                    # - sex
                    # - adoptable/pending adoption status

require 'rails_helper'

RSpec.describe "pets index page" do

  before :each do
    @shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
    @shelter_2 = Shelter.create!(name: "Shelter 2", address: "123 road", city: "Denver", state: "CO", zip: 80201)

    @pet_1 = Pet.create!(image: "brown_puppy.jpg", name: "Puppy1", age: 1, sex: "Male", shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(image: "english_bulldog.jpg", name: "Puppy2", age: 1, sex: "Female", shelter_id: @shelter_1.id)
    @pet_3 = Pet.create!(image: "golden.jpg", name: "Puppy3", age: 2, sex: "Female", shelter_id: @shelter_2.id)
    @pet_4 = Pet.create!(image: "cat.jpg", name: "Kitten1", age: 2, sex: "Male", shelter_id: @shelter_2.id)
  end


  it "Can see each pet info in '/pets/:id'" do
    visit "/pets/:id"

    expect(page).to have_xpath("//img['brown_puppy.jpg']")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.age)
    expect(page).to have_content(@pet_1.sex)
    expect(page).to have_content(@pet_1.shelter.name)
  end
end