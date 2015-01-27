class CreatePostPhotos < ActiveRecord::Migration
  def change
    create_table :post_photos do |t|
      t.string :photo, null: false
      t.point :geog, geographick: true, null: false
      t.float :image_direction, null: false
      t.text :note, null: false

      t.timestamps
    end
  end
end
