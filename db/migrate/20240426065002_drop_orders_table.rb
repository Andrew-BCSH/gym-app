class DropOrdersTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :orders
  end
end
