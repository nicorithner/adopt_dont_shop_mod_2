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

  it "In Shelter New page after filling out the form and submitting new shelter's info routes to Shelter Index" do
    visit '/shelters/new'

    fill_in 'shelter[name]', with: "New Shelter"
    fill_in 'shelter[address]', with: "123 street"
    fill_in 'shelter[city]', with: "Denver"
    fill_in 'shelter[state]', with: "CO"
    fill_in 'shelter[zip]', with: 80202
    click_on "Create Shelter"

    expect(current_path).to eq('/shelters')
    expect(page).to have_content("New Shelter")
  end
  
  it "When creating a new shelter there is a flash message if there are blank fields in the form" do
    visit '/shelters'
    click_on "New Shelter"
    expect(current_path).to eq('/shelters/new')


    fill_in 'shelter[name]', with: nil
    click_on "Create Shelter"
    
    expect(current_path).to eq('/shelters/new')
    expect(page).to have_content("Incomplete form")
  end 
end

