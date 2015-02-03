class CreateParkPhotos < ActiveRecord::Migration
  def change
    create_table :park_photos do |t|
      t.references :park, index: true, null: false
      t.references :post_photo, index: true, null: false

      t.timestamps
    end
  end
end
