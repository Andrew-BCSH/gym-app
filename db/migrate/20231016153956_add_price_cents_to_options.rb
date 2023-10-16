class AddPriceCentsToOptions < ActiveRecord::Migration[7.0]
  def change
    add_column :options, :price_cents, :integer
  end
end
