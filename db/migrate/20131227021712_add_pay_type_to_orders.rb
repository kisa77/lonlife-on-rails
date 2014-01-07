class AddPayTypeToOrders < ActiveRecord::Migration
  def change
      add_column :orders, :pay_type, :string, :default => ''
  end
end
