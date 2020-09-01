require "rails_helper"

RSpec.describe "Can delete shelter" do

  before :each do
    @shelter_1 = Shelter.create(name: "Shelter 1", address: "123 some st", city: "Denver", state: "CO", zip: 80202)
    @shelter_2 = Shelter.create(name: "Shelter 2", address: "123 some st", city: "Denver", state: "CO", zip: 80202)

    content_1 = "We loved taking our little baby here! Our yak loves
    getting his cute little paws worked on by Beth, she's amazing!"

    @review_1 = Review.create!(title: "Great place!", rating: 5,
                              content: content_1, optional_picture: "https://i.ibb.co/YLxykRV/yak.png",
                              shelter_id: @shelter_1.id)
  end

  it "can display a link and delete the shelter" do
    visit "/shelters"
    expect(page).to have_content("Shelter 1")
    expect(page).to have_content("Shelter 2")

    visit "/shelters/#{@shelter_2.id}"

    click_on "Delete"

    expect(current_path).to eq('/shelters')
    expect(page).to have_content("Shelter 1")
    expect(page).to_not have_content("Shelter 2")
  end

  it "When I delete a shelter, it deletes all reviews of said shelter" do
    visit "/shelters/#{@shelter_1.id}/reviews"

    expect(page).to have_content("We loved")
    expect(page).to have_content("she's amazing!")

    visit "/shelters"
    expect(page).to have_content("Shelter 1")
    expect(page).to have_content("Shelter 2")

    visit "/shelters/#{@shelter_1.id}"

    click_on "Delete"

    expect(current_path).to eq('/shelters')
    expect(page).to have_content("Shelter 2")
    expect(page).to_not have_content("Shelter 1")
  end
end
