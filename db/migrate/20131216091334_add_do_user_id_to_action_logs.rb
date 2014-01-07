class AddDoUserIdToActionLogs < ActiveRecord::Migration
  def change
      add_column :action_logs, :do_user_id, :integer
  end

  def down
      remove_column :action_logs, :do_user_id
  end
end
