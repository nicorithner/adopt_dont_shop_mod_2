require "rails_helper"

RSpec.describe "Shelter Update" do

  before :each do
    @shelter_1 = Shelter.create(name: "Shelter 1", address: "123 some st", city: "Denver", state: "CO", zip: 80202)
  end
  
  it "From Shelter show page clicking 'Update Shelter' link routes to 'shelters/:id/edit'" do
    visit "/shelters/#{@shelter_1.id}"
    click_on "Update Shelter"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
  end

  it "Can update shelter info, click submit, and be redirected to shelter's show page where update is reflected" do
    visit "/shelters/#{@shelter_1.id}/edit"

    fill_in :name, with: "Updated Name"
    click_on "Submit Changes"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    expect(page).to have_content("Updated Name")
    expect(page).to_not have_content("Shelter 1")
  end
  
end