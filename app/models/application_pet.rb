class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :app
end
