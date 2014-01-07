class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :server_name
      t.integer :server_region_id
    end
  end
end
