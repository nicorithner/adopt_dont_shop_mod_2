require 'rails_helper'

RSpec.describe "Approve an application" do

  describe "As a visitor" do
    describe "When I visit an application's show page" do
      describe "For every pet that the application is for, I see a link to approve the application for that specific pet" do
        describe "When I click on a link to approve the application for one particular pet" do
          describe "I'm taken back to that pet's show page" do
            describe "And I see that the pets status has changed to 'pending'" do
              it "And I see text on the page that says who this pet is on hold for (Ex: 'On hold for John Smith', given John Smith is the name on the application that was just accepted)" do

                shelter_1 = Shelter.create(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
                shelter_2 = Shelter.create(name: "Shelter 2", address: "123 road", city: "Denver", state: "CO", zip: 80201)
                pet_1 = Pet.create(image: "brown_puppy.jpg", name: "Puppy1", age: 1, sex: "Male", shelter_id: shelter_1.id)
                pet_2 = Pet.create(image: "english_bulldog.jpg", name: "Puppy2", age: 1, sex: "Female", shelter_id: shelter_1.id)
                pet_3 = Pet.create(image: "golden.jpg", name: "Puppy3", age: 2, sex: "Female", shelter_id: shelter_2.id)
                pet_4 = Pet.create(image: "cat.jpg", name: "Kitten1", age: 2, sex: "Male", shelter_id: shelter_2.id)

                app_1 = App.create!(name: "Bob", city: "Denver", state: "CO", zip: 87665, phone_number: "3039997865", address: "5576 South Yup Street", description: "yup")
                app_2 = App.create!(name: "Tim", city: "Lakewood", state: "UT", zip: 344900, phone_number: "7889007654", address: "5576 North La Road", description: "This is a description")

                ApplicationPet.create!(app: app_1, pet: pet_1)
                ApplicationPet.create!(app: app_1, pet: pet_3)
                ApplicationPet.create!(app: app_2, pet: pet_2)

                visit "/applications/#{app_1.id}"
                expect(page).to have_content("#{pet_1.name}")

                within("#application-#{app_1.id}") do
                  click_on("Approve application for #{pet_1.name}")
                end

                expect(current_path).to eq("/pets/#{pet_1.id}")
                # save_and_open_page
                expect(page).to have_content("Application approved")
                expect(page).to have_content("#{pet_1.status}: pending")
                expect(page).to have_content("On hold for: #{app_1.name}")
              end
            end
          end
        end
      end
    end
    describe "When an application is made for more than one pet" do
      describe "When I visit that applications show page" do
        it "I'm able to approve the application for any number of pets" do
          shelter_1 = Shelter.create(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
          shelter_2 = Shelter.create(name: "Shelter 2", address: "123 road", city: "Denver", state: "CO", zip: 80201)
          pet_1 = Pet.create(image: "brown_puppy.jpg", name: "Puppy1", age: 1, sex: "Male", shelter_id: shelter_1.id)
          pet_2 = Pet.create(image: "english_bulldog.jpg", name: "Puppy2", age: 1, sex: "Female", shelter_id: shelter_1.id)
          pet_3 = Pet.create(image: "golden.jpg", name: "Puppy3", age: 2, sex: "Female", shelter_id: shelter_2.id)
          pet_4 = Pet.create(image: "cat.jpg", name: "Kitten1", age: 2, sex: "Male", shelter_id: shelter_2.id)

          app_1 = App.create!(name: "Bob", city: "Denver", state: "CO", zip: 87665, phone_number: "3039997865", address: "5576 South Yup Street", description: "yup")
          app_2 = App.create!(name: "Tim", city: "Lakewood", state: "UT", zip: 344900, phone_number: "7889007654", address: "5576 North La Road", description: "This is a description")

          ApplicationPet.create!(app: app_1, pet: pet_1)
          ApplicationPet.create!(app: app_1, pet: pet_3)
          ApplicationPet.create!(app: app_2, pet: pet_2)

          visit "/applications/#{app_1.id}"
          expect(page).to have_content("#{pet_1.name}")

          within("#application-#{app_1.id}") do
            click_on("Approve application for #{pet_1.name}")
          end

          visit "/applications/#{app_1.id}"
          expect(page).to have_content("#{pet_3.name}")

          within("#application-#{app_1.id}") do
            click_on("Approve application for #{pet_3.name}")
          end
        end
      end
    end
    describe "When a pet has more than one application made for them" do
      describe "And one application has already been approved for them" do
        it "I can not approve any other applications for that pet but all other applications still remain on file (they can be seen on the pets application index page)" do
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
        end
      end
    end
  end
end
