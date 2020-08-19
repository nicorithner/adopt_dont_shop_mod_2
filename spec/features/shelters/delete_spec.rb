require "rails_helper"

RSpec.describe "Can delete shelter" do

  before :each do
    @shelter_1 = Shelter.create(name: "Shelter 1", address: "123 some st", city: "Denver", state: "CO", zip: 80202)
    @shelter_2 = Shelter.create(name: "Shelter 2", address: "123 some st", city: "Denver", state: "CO", zip: 80202)
  end

  it "can display a link and delete the shelter" do
    visit "/shelters"
    expect(page).to have_content("Shelter 1")
    expect(page).to have_content("Shelter 2")

    visit "/shelters/#{@shelter_1.id}"

    click_on "Delete"

    expect(current_path).to eq('/shelters')
    expect(page).to have_content("Shelter 2")
    expect(page).to_not have_content("Shelter 1")
  end
end