class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :game_name
      t.string :initial
      t.string :game_alias
      t.integer :server_region_id
      t.timestamps
    end
  end
end
