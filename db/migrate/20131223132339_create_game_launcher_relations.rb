class CreateGameLauncherRelations < ActiveRecord::Migration
  def change
    create_table :game_launcher_relations do |t|
      t.integer :game_id
      t.integer :game_launcher_id
    end
  end
end
