class CreateGameClienterRelations < ActiveRecord::Migration
  def change
    create_table :game_clienter_relations do |t|
      t.integer :game_id
      t.integer :game_clienter_id
    end
  end
end
