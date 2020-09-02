require 'rails_helper'

RSpec.describe 'Shelters show page' do
  before :each do
    @content_1 = "We loved taking our little baby here! Our yak loves
    getting his cute little paws worked on by Beth, she's amazing!"

    @shelter_1 = Shelter.create!(name:       "Dave's Barn",
                         address:      '208 South Yup Street',
                         city:  'LakeSmall',
                        state: 'CO',
                        zip: 87663)

    @review_1 = Review.create!(title: "Great place!", rating: 5,
                              content: @content_1, optional_picture: "https://i.ibb.co/YLxykRV/yak.png",
                              shelter_id: @shelter_1.id)

  end

  describe "When I visit a shelter's show page," do
    it "I see a list of reviews for that shelter" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content("Great place!")
      expect(page).to have_content("We loved taking our little baby here! Our yak loves getting his cute little paws worked on by Beth, she's amazing!")
      expect(page).to have_content("https://i.ibb.co/YLxykRV/yak.png")
    end
  end
end

RSpec.describe 'Shelters show page' do
  before :each do
    @content_1 = "We loved taking our little baby here! Our yak loves
    getting his cute little paws worked on by Beth, she's amazing!"

    @shelter_1 = Shelter.create!(name:       "Dave's Barn",
                        address:      '208 South Yup Street',
                        city:  'LakeSmall',
                        state: 'CO',
                        zip: 87663)

    @review_1 = Review.create!(title: "Great place!", rating: 5,
                              content: @content_1,
                              shelter_id: @shelter_1.id)
    @review_2 = Review.create!(title: "Great place!", rating: 3,
                              content: @content_1,
                              shelter_id: @shelter_1.id)

  end

  describe "When I visit a shelter's show page," do
    it "I see a list of reviews for that shelter" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content("Great place!")
      expect(page).not_to have_content("https://i.ibb.co/YLxykRV/yak.png")
      expect(page).to have_content("We loved taking our little baby here!")
      expect(page).to have_content("Average Review: 4")

    end
  end
end
