class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title, :limit => 300, null: false
      t.string :description, :limit => 500, null: false
      t.string :country, :limit => 41, null: false
      t.string :tags, :limit => 255, null: false
      t.decimal :price, precision: 7, scale: 2, null: false, default: 0

      t.timestamps
    end
  end
end
