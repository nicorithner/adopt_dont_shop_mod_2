class FavoritePet
  attr_reader :favorites
  def initialize(favorites)
    if favorites
      @favorites = favorites
    else
      @favorites = Array.new
    end
  end

  def add_pet(pet)
    @favorites << pet.id.to_s
  end
  
  def favorites_count
    @favorites.count
  end
end
