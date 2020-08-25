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


  it "From Shelter Index, 'New Review' link routes to '/shelters/:shelter_id/reviews/new'" do
    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_selector(:link_or_button, "New Review")

    click_on "New Review"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")
  end

  it "Can create a new review and see it in shelter's index page" do
    visit "/shelters/#{@shelter_1.id}/reviews/new"

    fill_in :title, with: "Good, not great"
    fill_in :rating, with: 3
    fill_in :content, with: "It was alright, we weren't impressed."
    fill_in :optional_picture, with: "here's a photo"

    click_on "Submit Review"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews")

    expect(page).to have_content("Good, not great")
    expect(page).to have_content("we weren't")
  end

end
