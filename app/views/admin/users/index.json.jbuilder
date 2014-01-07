json.array!(@users) do |user|
  json.extract! user, :id, :name, :comment_mode, :comment_sort, :theme, :signature, :signature_format, :status, :timezone, :language, :picture, :init_email, :data, :phone, :qq, :expire_date, :expire_days, :expire_time, :introducer, :invite_token, :is_verify_email, :is_buy, :money, :game_type, :is_pause, :pause_time, :is_mac, :login_success_times, :login_fail_times, :allow_client_number, :is_blocked, :register_source
  json.url admin_user_url(user, format: :json)
end
