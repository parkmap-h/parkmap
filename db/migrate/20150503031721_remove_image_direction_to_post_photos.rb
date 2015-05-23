class RemoveImageDirectionToPostPhotos < ActiveRecord::Migration
  def change
    remove_column :post_photos, :image_direction, :float
  end
end
