class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :comment_mode
      t.integer :comment_sort
      t.string :theme
      t.string :signature
      t.string :signature_format
      t.integer :status
      t.string :timezone
      t.string :language
      t.string :picture
      t.string :init_email
      t.text :data
      t.string :phone
      t.string :qq
      t.date :expire_date
      t.integer :expire_days
      t.datetime :expire_time
      t.integer :introducer
      t.string :invite_token
      t.integer :is_verify_email
      t.integer :is_buy
      t.integer :money
      t.string :game_type
      t.integer :is_pause
      t.datetime :pause_time
      t.integer :is_mac
      t.integer :login_success_times
      t.integer :login_fail_times
      t.integer :allow_client_number
      t.integer :is_blocked
      t.string :register_source

      t.timestamps
    end
  end
end
