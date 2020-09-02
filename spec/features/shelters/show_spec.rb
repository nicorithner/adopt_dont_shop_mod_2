require "rails_helper"

RSpec.describe "shelter show page" do

  before :each do
    @content_1 = "We loved taking our little baby here! Our yak loves
    getting his cute little paws worked on by Beth, she's amazing!"
    
    @shelter_1 = Shelter.create!(name:       "Dave's Barn",
    address:      '208 South Yup Street',
    city:  'LakeSmall',
    state: 'CO',
    zip: 87663)
    @shelter_2 = Shelter.create(name: "Shelter 2", address: "123 some st", city: "Denver", state: "CO", zip: 80202)
    @pet_1 = Pet.create!(image: "brown_puppy.jpg", name: "Puppy1", age: 1, sex: "Male", shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(image: "english_bulldog.jpg", name: "Puppy2", age: 1, sex: "Female", shelter_id: @shelter_1.id)
    @review_1 = Review.create!(title: "Great place!", rating: 5,
                              content: @content_1,
                              shelter_id: @shelter_1.id)
    @review_2 = Review.create!(title: "Great place!", rating: 3,
                              content: @content_1,
                              shelter_id: @shelter_1.id)
                              
    @app_1 = App.create!(name: "Bob", city: "Denver", state: "CO", zip: 87665, phone_number: "3039997865", address: "5576 South Yup Street", description: "yup")
    ApplicationPet.create!(app: @app_1, pet: @pet_1)
  end

  it "I see the shelter with that id including the shelter's information" do
    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.address)
    expect(page).to have_content(@shelter_1.city)
    expect(page).to have_content(@shelter_1.state)
    expect(page).to have_content(@shelter_1.zip)

    expect(page).to_not have_content(@shelter_2.name)
  end

  describe "When I visit a shelter's show page," do
    it "I see the shelter stats" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content("Total Pets: 2")
      expect(page).to have_content("Average Review: 4")
      save_and_open_page
      expect(page).to have_content("Total Pending Applications:1")
    end
  end
end

