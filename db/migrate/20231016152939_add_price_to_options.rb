class AddPriceToOptions < ActiveRecord::Migration[7.0]
  def change
    add_monetize :options, :price, currency: { present: false }
  end
end
