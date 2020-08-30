require 'rails_helper'

RSpec.describe "the Applications index page" do
  it "should display all applications" do
    shelter_1 = Shelter.create(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
    shelter_2 = Shelter.create(name: "Shelter 2", address: "123 road", city: "Denver", state: "CO", zip: 80201)
    pet_1 = Pet.create(image: "brown_puppy.jpg", name: "Puppy1", age: 1, sex: "Male", shelter_id: shelter_1.id)
    pet_2 = Pet.create(image: "english_bulldog.jpg", name: "Puppy2", age: 1, sex: "Female", shelter_id: shelter_1.id)
    pet_3 = Pet.create(image: "golden.jpg", name: "Puppy3", age: 2, sex: "Female", shelter_id: shelter_2.id)
    pet_4 = Pet.create(image: "cat.jpg", name: "Kitten1", age: 2, sex: "Male", shelter_id: shelter_2.id)
    app_1 = App.create!(name: "Bob", city: "Denver", state: "CO", zip: 87665, phone_number: "3039997865", address: "5576 South Yup Street", description: "yup")
    app_2 = App.create!(name: "Tim", city: "Lakewood", state: "UT", zip: 344900, phone_number: "7889007654", address: "5576 North La Road", description: "This is a description")

    ApplicationPet.create!(app: app_1, pet: pet_1)
    ApplicationPet.create!(app: app_2, pet: pet_2)

    visit "/applications/#{app_1.id}"

    expect(page).to have_content(app_1.name)
    expect(page).to have_content(app_1.city)
    expect(page).to have_content(app_1.state)
    expect(page).to have_content(app_1.address)
    expect(page).to have_content(app_1.zip)
    expect(page).to have_content(app_1.phone_number)
    expect(page).to have_content(app_1.description)
    expect(page).to have_content(pet_1.name)

    click_link "#{pet_1.name}"
    expect(current_path).to eq("/pets/#{pet_1.id}")
  end
  describe "As a visitor" do
    describe "When I visit a pets show page" do
      describe "I see a link to view all applications for this pet" do
        describe "When I click that link" do
          describe "I can see a list of all the names of applicants for this pet" do
            it "Each applicant's name is a link to their application show page" do

              shelter_1 = Shelter.create(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
              shelter_2 = Shelter.create(name: "Shelter 2", address: "123 road", city: "Denver", state: "CO", zip: 80201)
              pet_1 = Pet.create(image: "brown_puppy.jpg", name: "Puppy1", age: 1, sex: "Male", shelter_id: shelter_1.id)
              pet_2 = Pet.create(image: "english_bulldog.jpg", name: "Puppy2", age: 1, sex: "Female", shelter_id: shelter_1.id)
              pet_3 = Pet.create(image: "golden.jpg", name: "Puppy3", age: 2, sex: "Female", shelter_id: shelter_2.id)
              pet_4 = Pet.create(image: "cat.jpg", name: "Kitten1", age: 2, sex: "Male", shelter_id: shelter_2.id)
              app_1 = App.create!(name: "Bob", city: "Denver", state: "CO", zip: 87665, phone_number: "3039997865", address: "5576 South Yup Street", description: "yup")
              app_2 = App.create!(name: "Tim", city: "Lakewood", state: "UT", zip: 344900, phone_number: "7889007654", address: "5576 North La Road", description: "This is a description")

              ApplicationPet.create!(app: app_1, pet: pet_1)
              ApplicationPet.create!(app: app_2, pet: pet_2)

              visit "/pets/#{pet_1.id}"

              within("#links") do
                expect(page).to have_link("View all applications for #{pet_1.name}")
              end

              within("#links") do
                click_link "View all applications for #{pet_1.name}"
              end
              expect(current_path).to eq("/pets/#{pet_1.id}/applications")

              expect(page).to have_content(app_1.name)
              expect(page).to have_link("#{app_1.name}")
              click_link "#{app_1.name}"
              expect(current_path).to eq("/applications/#{app_1.id}")
            end
            describe "When I visit a pet applications index page for a pet that has no applications on them" do
              it "I see a message saying that there are no applications for this pet yet" do

                shelter_1 = Shelter.create(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
                pet_1 = Pet.create(image: "brown_puppy.jpg", name: "Puppy1", age: 1, sex: "Male", shelter_id: shelter_1.id)

                visit "/pets/#{pet_1.id}/applications"

                expect(page).to have_content("Lucky for you, there are no applications pending for this pet at the moment!")

              end
            end
          end
        end
      end
    end
  end
end
