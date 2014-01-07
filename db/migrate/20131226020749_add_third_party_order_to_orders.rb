class AddThirdPartyOrderToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :third_party_order, :string
  end
end
