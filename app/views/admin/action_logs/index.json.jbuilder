json.array!(@action_logs) do |action_log|
  json.extract! action_log, :id, :user_id, :target_user, :do_user, :information, :log_type, :description
  json.url admin_action_log_url(action_log, format: :json)
end
