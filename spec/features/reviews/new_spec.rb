require 'rails_helper'

RSpec.describe "add review to shelter" do

  before :each do
    @shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
    content_1 = "We loved taking our little baby here! Our yak loves
    getting his cute little paws worked on by Beth, she's amazing!"

    review_1 = Review.create!(title: "Great place!", rating: 5,
                              content: content_1, optional_picture: "https://i.ibb.co/YLxykRV/yak.png")
  end


  it "From Shelter Index, 'New Review' link routes to '/shelters/:shelter_id/reviews/new'" do
    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_selector(:link_or_button, 'New Review')

    click_on "New Review"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")
  end

  it "Can create a new review and see it in shelter's index page" do
    visit "/shelters/#{@shelter_1.id}/reviews/new"

    fill_in :title, with: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg"
    fill_in :rating, with: "Snowy"
    fill_in :content, with: 1
    fill_in :optional_picture, with: "Female"

    click_on "Submit Review"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/shelters")

    expect(page).to have_content("Great Place!")
    expect(page).to have_content("We loved")
  end

end
