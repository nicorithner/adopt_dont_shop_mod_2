## Favorite a Pet
Users will be able to favorite a pet and keep track of pet's they're interested in


### User Story 8, Favorite Indicator
- [ ] done

As a visitor
I see a favorite indicator in my navigation bar
The favorite indicator shows a count of pets in my favorites list
I can see this favorite indicator from any page in the application

#### Notes: 

A VISITOR can vote a pet as favorite, and because we have no "users", I think PETS will need a column in their table to say they are a FAVORITE. 

  - [x] Add favorite indicator in the nav bar
  - [x] Add column 'favorite:boolean' to  pets table
  <!--rails generate migration add_favorite_to_pets favorite:boolean-->
<!--rails db:migrate-->
  - [x] pet[:favorite] = false by default
  - [x] Favorite indicator shows count of fav pets
  - [ ] Nav bar - with indicator - is in every page



### User Story 9, Favorite Creation
- [x] done

As a visitor
When I visit a pet's show page
I see a button or link to favorite that pet
When I click the button or link
I'm taken back to that pet's show page
I see a flash message indicating that the pet has been added to my favorites list
The favorite indicator in the nav bar has incremented by one

#### Notes: 
  - [x] Add favorite link to toggling pet's favorite status to true.
      `@pet_1.toggle(:favorite)` works but I need a way to implement it on click
  - [x] Clicking the favorite link visitor remains in show page.
  - [x] flash message indicating that the pet has been added.
  - [x] Favorite indicator shows updated count of fav pets

### User Story 10, Favorite Index Page
- [x] done

As a visitor
When I have added pets to my favorites list
And I visit my favorites index page ("/favorites")
I see all pets I've favorited
Each pet in my favorites shows the following information:
- pet's name (link to pets show page)
- pet's image

#### Notes & To_do

  - [x] Set Tests
  - [x] ("/favorites")
  - [x] Favorite pets are listed at ("/favorites")
    - [x] Name (is link)
    - [x] Image
Ways to verify boolean:
  `expect(@pet_1[:favorite]).to be_in([true])`
  `expect(@pet_1.favorite).to eq(true)`

### User Story 11, Favorite Indicator links to Index Page
- [x] done

As a visitor
When I click on the favorite indicator in the nav bar
I am taken to the favorites index page


### User Story 12, Can't Favorite a Pet More Than Once
- [x] done

As a visitor
After I've favorited a pet
When I visit that pet's show page
I no longer see a link to favorite that pet
But I see a link to remove that pet from my favorites
When I click that link
A delete request is sent to "/favorites/:pet_id"
And I'm redirected back to that pets show page where I can see a flash message indicating that the pet was removed from my favorites
And I can now see a link to favorite that pet
And I also see that my favorites indicator has decremented by 1

#### Notes & To_do
  - [x] Set up tests
    After a pet is favorited
    - [x] visit page show page the Favorite link is no longer visible.
    - [x] Remove Favorite link is visible instead.
    - [x] Clicking Remove Favorite a delete request is sent to "/favorites/:pet_id".
      - [x] After clicking remain in pet's show page.
      - [x] Flash message indicating pet was removed from favorites.
      - [x] Favorite link is visible again.
      - [x] Favorites count decreased by one.


### User Story 13, Remove a Favorite from Favorites Page
- [x] done

As a visitor
When I have added pets to my favorites list
And I visit my favorites page ("/favorites")
Next to each pet, I see a button or link to remove that pet from my favorites
When I click on that button or link to remove a favorite
A delete request is sent to "/favorites/:pet_id"
And I'm redirected back to the favorites page where I no longer see that pet listed
And I also see that the favorites indicator has decremented by 1

#### Notes & To_do
  - [x] Set up tests
    When I have added pets to my favorites list
    - [x] visit my favorites page and a 'remove favorite' link is visible next to EACH pet.
    - [x] Clicking 'Remove Favorite' a delete request is sent to "/favorites/:pet_id".
      - [x] After clicking remain in Favorites page.
      - [x] Favorites count decreased by one.


### User Story 14, No Favorites Page
- [x] done

As a visitor
When I have not added any pets to my favorites list
And I visit my favorites page ("/favorites")
I see text saying that I have no favorited pets


### User Story 15, Remove all Favorite from Favorites Page
- [ ] done

As a visitor
When I have added pets to my favorites list
And I visit my favorites page ("/favorites")
I see a link to remove all favorited pets
When I click that link
I'm redirected back to the favorites page
I see the text saying that I have no favorited pets
And the favorites indicator returns to 0