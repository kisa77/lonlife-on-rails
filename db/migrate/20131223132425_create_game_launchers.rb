class CreateGameLaunchers < ActiveRecord::Migration
  def change
    create_table :game_launchers do |t|
      t.string :game_launcher_name
    end
  end
end
