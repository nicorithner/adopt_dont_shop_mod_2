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

  it "Shelter Update From Shelter Index Page" do

    visit "/shelters"
    expect(page).to have_content("Edit #{shelter_1.name}")
    expect(page).to have_content("Edit #{shelter_2.name}")

    click_on "Edit #{shelter_1.name}"
    expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

    fill_in :name, with: "New name"

    click_on "Submit"
    expect(current_path).to eq("/shelters")
    expect(page).to_not have_content("Edit #{shelter_1.name}")
    expect(page).to have_content("New name")
  end

end