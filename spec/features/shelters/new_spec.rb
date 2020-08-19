# User Story 4, Shelter Creation

# As a visitor
  # When I visit the Shelter Index page
        # Then I see a link to create a new Shelter, "New Shelter"
  # When I click this link
        # Then I am taken to '/shelters/new' 
        # where I  see a form for a new shelter

  # When I fill out the form with a new shelter's info And I click the button "Create Shelter" to submit the form
        # a new shelter is created,
        # and I am redirected to the Shelter Index page where I see the new Shelter listed.

require "rails_helper"

RSpec.describe "Shelter Creation" do

  before :each do
    @shelter_1 = Shelter.create(name: "Shelter 1", address: "123 some st", city: "Denver", state: "CO", zip: 80202)
    @shelter_2 = Shelter.create(name: "Shelter 2", address: "123 some st", city: "Denver", state: "CO", zip: 80202)
  end
  
  it "From Shelter Index page clicking 'New Shelter' link routes to 'shelters/new'" do
    visit '/shelters'
    click_on "New Shelter"

    expect(current_path).to eq('/shelters/new')
  end
  
end

