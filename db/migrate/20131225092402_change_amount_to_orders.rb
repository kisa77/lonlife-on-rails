class ChangeAmountToOrders < ActiveRecord::Migration
  def change
      change_column :orders, :amount, :decimal, precision:8, scale:2
      change_column :orders, :balance, :decimal, precision:8, scale:2
  end
end
