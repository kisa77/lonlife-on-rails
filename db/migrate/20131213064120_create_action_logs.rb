class CreateActionLogs < ActiveRecord::Migration
  def change
    create_table :action_logs do |t|
      t.integer :log_type
      t.integer :user_id
      t.string :target_user
      t.string :do_user
      t.string :information, limit: 2048
      t.string :description, limit: 2048

      t.timestamps
    end

    add_index :action_logs, :user_id
    add_index :action_logs, :updated_at
  end
end
