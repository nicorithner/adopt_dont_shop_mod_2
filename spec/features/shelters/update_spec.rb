# User Story 5, Shelter Update
# As a visitor
# When I visit a shelter show page
#     When I click the link "Update Shelter"
#         Then I am taken to '/shelters/:id/edit' 
              #where I  see a form to edit the shelter's data including:
                                                                        # - name
                                                                        # - address
                                                                        # - city
                                                                        # - state
                                                                        # - zip
                  # And I click the button to submit the form the shelter's info is updated,
                        # and I am redirected to the Shelter's Show page 
                                  #where I see the shelter's updated info

require "rails_helper"

RSpec.describe "Shelter Update" do

  before :each do
    @shelter_1 = Shelter.create(name: "Shelter 1", address: "123 some st", city: "Denver", state: "CO", zip: 80202)
    @shelter_2 = Shelter.create(name: "Shelter 2", address: "123 some st", city: "Denver", state: "CO", zip: 80202)
  end
  
  it "From Shelter show page clicking 'Update Shelter' link routes to 'shelters/:id/edit'" do
    visit "/shelters/#{@shelter_1.id}"
    click_on "Update Shelter"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
  end

  # it "In Shelter New page after filling out the form and submitting new shelter's info routes to Shelter Index" do
  #   visit '/shelters/new'

  #   fill_in 'shelter[name]', with: "New Shelter"
  #   fill_in 'shelter[address]', with: "123 street"
  #   fill_in 'shelter[city]', with: "Denver"
  #   fill_in 'shelter[state]', with: "CO"
  #   fill_in 'shelter[zip]', with: 80202
  #   click_on "Create Shelter"

  #   expect(current_path).to eq('/shelters')
  #   expect(page).to have_content("New Shelter")
  # end
  
end