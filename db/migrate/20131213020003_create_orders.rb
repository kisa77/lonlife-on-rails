class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :email
      t.string :user_id
      t.string :order_id
      t.integer :status,        :default => 0
      t.string :receiver
      t.integer :amount
      t.integer :balance
      t.integer :days
      t.integer :game_id
      t.integer :product_id
      t.string :lottery_code
      t.string :coupon
      t.string :pay_bank
      t.integer :card_type

      t.timestamps
    end

    add_index :orders, :updated_at, name: 'index_updated_at'
    add_index :orders, :order_id, name: 'index_order_id'
  end
end
