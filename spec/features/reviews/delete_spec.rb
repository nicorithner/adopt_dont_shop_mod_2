require 'rails_helper'

RSpec.describe "Reviews have delete button" do
  before :each do
    content_1 = "We loved taking our little baby here! Our yak loves getting his cute little paws worked on by Beth, she's amazing!"
    @shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)

    @review_1 = Review.create!(title: "Great place!", rating: 5,
                              content: content_1, optional_picture: "https://i.ibb.co/YLxykRV/yak.png",
                              shelter_id: @shelter_1.id)
end

  it "When I visit a shelter's show page, I see a link next to each shelter review to delete the review. When I delete a shelter review, I am returned to shelter's show page" do
    visit "/shelters/#{@shelter_1.id}/reviews"

    expect(page).to have_selector(:link_or_button, 'Delete Review')
    click_on 'Delete Review'

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews")
  end
end
