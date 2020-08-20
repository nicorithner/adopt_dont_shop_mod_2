# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shelter_1 = Shelter.create(name: "Shelter 1", address: "123 st", city: "Denver", state: "CO", zip: 80202)
    shelter_2 = Shelter.create(name: "Shelter 2", address: "123 road", city: "Denver", state: "CO", zip: 80201)
pet_1 = Pet.create(image: "brown_puppy.jpg", name: "Puppy1", age: 1, sex: "Male", shelter_id: shelter_1.id)
pet_2 = Pet.create(image: "english_bulldog.jpg", name: "Puppy2", age: 1, sex: "Female", shelter_id: shelter_1.id)
pet_3 = Pet.create(image: "golden.jpg", name: "Puppy3", age: 2, sex: "Female", shelter_id: shelter_2.id)
pet_4 = Pet.create(image: "cat.jpg", name: "Kitten1", age: 2, sex: "Male", shelter_id: shelter_2.id)