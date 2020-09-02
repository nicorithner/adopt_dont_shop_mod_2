class AddAppPendingToPets < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :application_pending, :boolean
  end
end
