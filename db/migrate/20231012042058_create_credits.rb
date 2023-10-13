class CreateCredits < ActiveRecord::Migration[7.0]
  def change
    create_table :credits do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :balance

      t.timestamps
    end
  end
end
