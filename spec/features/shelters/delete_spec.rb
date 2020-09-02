require "rails_helper"

RSpec.describe "Can delete shelter" do

  before :each do
    @shelter_1 = Shelter.create(name: "Shelter 1", address: "123 some st", city: "Denver", state: "CO", zip: 80202)
    @shelter_2 = Shelter.create(name: "Shelter 2", address: "123 some st", city: "Denver", state: "CO", zip: 80202)
    @shelter_3 = Shelter.create(name: "Shelter 3", address: "222 some Rd", city: "Lakewood", state: "UT", zip: 80355)

    @pet_1 = Pet.create!(image: "golden.jpg", name: "Puppy3", age: 2, sex: "Female", shelter_id: @shelter_1.id, status: "adoptable", description: "Sweet and full of energy golden retriever", application_pending: true)
    @pet_3 = Pet.create!(image: "golden.jpg", name: "Puppy3", age: 2, sex: "Female", shelter_id: @shelter_2.id, status: "adoptable", description: "Sweet and full of energy golden retriever", application_pending: false)
    @pet_4 = Pet.create!(image: "cat.jpg", name: "Kitten1", age: 2, sex: "Male", shelter_id: @shelter_2.id, status: "pending", description: "Aloof Siamese cat", application_pending: false)

    content_1 = "We loved taking our little baby here! Our yak loves
    getting his cute little paws worked on by Beth, she's amazing!"

    @review_1 = Review.create!(title: "Great place!", rating: 5,
                              content: content_1, optional_picture: "https://i.ibb.co/YLxykRV/yak.png",
                              shelter_id: @shelter_3.id)
  end

  it "can display a link and delete the shelter" do
    visit "/shelters"
    expect(page).to have_content("Shelter 1")
    expect(page).to have_content("Shelter 2")
    expect(page).to have_content("Shelter 3")


    visit "/shelters/#{@shelter_3.id}"

    click_on "Delete"

    expect(current_path).to eq('/shelters')
    expect(page).to have_content("Shelter 1")
    expect(page).to_not have_content("Shelter 3")
  end

  it "When I delete a shelter, it deletes all reviews of said shelter" do
    visit "/shelters/#{@shelter_3.id}/reviews"

    expect(page).to have_content("We loved")
    expect(page).to have_content("she's amazing!")

    visit "/shelters"
    expect(page).to have_content("Shelter 1")
    expect(page).to have_content("Shelter 2")

    visit "/shelters/#{@shelter_3.id}"

    click_on "Delete"

    expect(current_path).to eq('/shelters')
    expect(page).to have_content("Shelter 2")
    expect(page).to_not have_content("Shelter 3")
  end

  it "Can delete a shelter as long as no pets in it have pending application" do

    visit "/shelters"
    expect(page).to have_content("Shelter 1")
    expect(page).to have_content("Shelter 2")

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to_not have_content("Delete")

    visit "/shelters/#{@shelter_3.id}"
    expect(page).to have_content("Delete")


  end
end
