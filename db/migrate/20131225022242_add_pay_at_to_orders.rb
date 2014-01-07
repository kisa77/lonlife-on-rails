class AddPayAtToOrders < ActiveRecord::Migration
  def up
      add_column :orders, :pay_at, :datetime
  end

  def down
      remove_column :orders, :pay_at
  end
end
