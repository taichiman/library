class AddPlaceIdToBooks < ActiveRecord::Migration
  def change
    add_column :books, :place_id, :integer
  end
end
