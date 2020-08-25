class AddOptionalPictureToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :optional_picture, :string, :default => 'none'
  end
end
