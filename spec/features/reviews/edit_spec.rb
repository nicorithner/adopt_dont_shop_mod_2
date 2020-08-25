require 'rails_helper'

RSpec.describe "add review to shelter" do

  before :each do
    content_1 = "We loved taking our little baby here! Our yak loves
    getting his cute little paws worked on by Beth, she's amazing!"
    @shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)

    @review_1 = Review.create!(title: "Great place!", rating: 5,
                              content: content_1, optional_picture: "https://i.ibb.co/YLxykRV/yak.png",
                              shelter_id: @shelter_1.id)
  end


  it "When I visit a shelter's show page I see a link to edit the shelter review next to each review" do
    visit "/shelters/#{@shelter_1.id}/reviews"
    expect(page).to have_selector(:link_or_button, "Edit Review")

    click_on "Edit Review"
    expect(current_path).to eq("/reviews/#{@review_1.id}/edit")
    expect(page).to have_content("We loved")
  end

  it "When the form is submitted, I should return to that shelter's show page" do
    visit "/reviews/#{@review_1.id}/edit"

    click_on "Update Review"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews")

    expect(page).to have_content("Great place!")
  end

end
