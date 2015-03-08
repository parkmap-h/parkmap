class AddFeeToParks < ActiveRecord::Migration
  def change
    add_column :parks, :fee, :json, nul: false, default: { type: 'text', text: '' }
  end
end
