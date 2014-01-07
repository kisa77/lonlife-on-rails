class CreateServerRegions < ActiveRecord::Migration
  def change
    create_table :server_regions do |t|
      t.string :server_region_name
    end
  end
end
