require "rails_helper"

RSpec.describe "shelter index page" do

  before :each do
    @shelter_1 = Shelter.create(name: "Shelter 1", address: "123 some st", city: "Denver", state: "CO", zip: 80202)
    @shelter_2 = Shelter.create(name: "Shelter 2", address: "123 some st", city: "Denver", state: "CO", zip: 80202)
  end
 
  it "I see the name of each shelter in the system" do
    visit '/shelters'

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
  end
  

  #==== Test 3
  # User Story 4, Shelter Creation
  # As a visitor
  # When I visit the Shelter Index page
  # Then I see a link to create a new Shelter, "New Shelter"
  # When I click this link
  # Then I am taken to '/shelters/new' where I  see a form for a new shelter
  # When I fill out the form with a new shelter's:
  # - name
  # - address
  # - city
  # - state
  # - zip
  # And I click the button "Create Shelter" to submit the form
  # Then a `POST` request is sent to '/shelters',
  # a new shelter is created,
  # and I am redirected to the Shelter Index page where I see the new Shelter listed.



  #==== Test 2
  # User Story 3, Shelter Show
  # As a visitor
  # When I visit '/shelters/:id'
  # Then I see the shelter with that id including the shelter's:
  # - name
  # - address
  # - city
  # - state
  # - zip

  

  #==== Test 4

  # User Story 5, Shelter Update
  # As a visitor
  # When I visit a shelter show page
  # Then I see a link to update the shelter "Update Shelter"
  # When I click the link "Update Shelter"
  # Then I am taken to '/shelters/:id/edit' where I  see a form to edit the shelter's data including:
  # - name
  # - address
  # - city
  # - state
  # - zip
  # When I fill out the form with updated information
  # And I click the button to submit the form
  # Then a `PATCH` request is sent to '/shelters/:id',
  # the shelter's info is updated,
  # and I am redirected to the Shelter's Show page where I see the shelter's updated info

  #==== Test 5
  # User Story 6, Shelter Delete
  # As a visitor
  # When I visit a shelter show page
  # Then I see a link to delete the shelter
  # When I click the link "Delete Shelter"
  # Then a 'DELETE' request is sent to '/shelters/:id',
  # the shelter is deleted,
  # and I am redirected to the shelter index page where I no longer see this shelter

end










