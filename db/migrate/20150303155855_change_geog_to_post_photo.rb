class ChangeGeogToPostPhoto < ActiveRecord::Migration
  def change
    change_column :post_photos, :geog, 'geography(Point,4326)', null: false
  end
end
