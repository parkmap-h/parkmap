class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|
      t.string :name, null: false
      t.st_point :geog, geographic: true, null: false

      t.timestamps
    end
  end
end
