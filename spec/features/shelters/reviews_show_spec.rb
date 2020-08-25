# require 'rails_helper'
#
# RSpec.describe 'Shelters show page' do
#   before :each do
#     content_1 = "We loved taking our little baby here! Our yak loves
#     getting his cute little paws worked on by Beth, she's amazing!"
#     @review_1 = Review.create!(title: "Great place!", rating: 5,
#                               content: content_1, optional_picture: "https://i.ibb.co/YLxykRV/yak.png")
#     @shelter_1 = Shelter.create!(name:       "Dave's Barn",
#                          address:      '208 South Yup Street',
#                          city:  'LakeSmall',
#                         state: 'CO',
#                         zip: 87663, review: @review_1)
#   end
#
#   describe "When I visit a shelter's show page," do
#     it "I see a list of reviews for that shelter" do
#       visit "/shelters/#{@shelter_1.id}"
#
#       expect(page).to have_content("Rating")
#     end
#   end
# end
