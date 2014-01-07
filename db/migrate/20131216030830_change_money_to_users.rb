class ChangeMoneyToUsers < ActiveRecord::Migration
  def up
      change_column :users, :money, :decimal, precision:8, scale:2
  end

  def down
      change_column :users, :money, :integer
  end
end
