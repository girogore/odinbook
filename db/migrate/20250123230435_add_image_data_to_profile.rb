class AddImageDataToProfile < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :image_data, :jsonb
  end
end
