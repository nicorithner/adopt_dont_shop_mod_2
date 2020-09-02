require 'rails_helper'

RSpec.describe "Approve an application" do

  describe "As a visitor" do
    describe "After an application has been approved for a pet" do
      describe "When I visit that applications show page" do
        describe "I no longer see a link to approve the application for that pet" do
          describe "But I see a link to unapprove the application for that pet" do
            describe "When I click on the link to unapprove the application" do
              describe "I'm taken back to that applications show page" do
                it " And I can see the button to approve the application for that pet again When I go to that pets show page I can see that the pets adoption status is now back to adoptable And that pet is not on hold anymore" do
                  shelter_1 = Shelter.create(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
                  shelter_2 = Shelter.create(name: "Shelter 2", address: "123 road", city: "Denver", state: "CO", zip: 80201)
                  pet_1 = Pet.create(image: "brown_puppy.jpg", name: "Puppy1", age: 1, sex: "Male", shelter_id: shelter_1.id, application_pending: true)
                  pet_2 = Pet.create(image: "english_bulldog.jpg", name: "Puppy2", age: 1, sex: "Female", shelter_id: shelter_1.id)
                  pet_3 = Pet.create(image: "golden.jpg", name: "Puppy3", age: 2, sex: "Female", shelter_id: shelter_2.id)
                  pet_4 = Pet.create(image: "cat.jpg", name: "Kitten1", age: 2, sex: "Male", shelter_id: shelter_2.id)

                  app_1 = App.create!(name: "Bob", city: "Denver", state: "CO", zip: 87665, phone_number: "3039997865", address: "5576 South Yup Street", description: "yup")
                  app_2 = App.create!(name: "Tim", city: "Lakewood", state: "UT", zip: 344900, phone_number: "7889007654", address: "5576 North La Road", description: "This is a description")

                  ApplicationPet.create!(app: app_1, pet: pet_1)
                  ApplicationPet.create!(app: app_1, pet: pet_3)
                  ApplicationPet.create!(app: app_2, pet: pet_1)

                  visit "/applications/#{app_1.id}"
                  expect(page).to have_content("#{pet_1.name}")

                  visit "/applications/#{app_2.id}"

                  expect(page).to have_content("#{pet_1.name} already has an application pending")

                  visit "/applications/#{app_1.id}"

                  expect(page).to have_content("#{pet_1.name} already has an application pending")

                  within("#application-#{app_1.id}") do
                    click_on("Unapprove application for #{pet_1.name}")
                  end

                  expect(current_path).to eq("/applications/#{app_1.id}")
                  
                  within("#application-#{app_1.id}") do
                    click_on("Approve application for #{pet_1.name}")
                  end

                end
              end
            end
          end
        end
      end
    end
  end
end
