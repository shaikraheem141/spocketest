class AddIndexesToProducColumns < ActiveRecord::Migration[6.0]
  def change
    add_index :products, :title
    add_index :products, :description
    add_index :products, :country
    add_index :products, :tags
  end
end
