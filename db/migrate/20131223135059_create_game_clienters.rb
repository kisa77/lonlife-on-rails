class CreateGameClienters < ActiveRecord::Migration
  def change
    create_table :game_clienters do |t|
      t.string :game_clienter_name
      t.timestamps
    end
  end
end
