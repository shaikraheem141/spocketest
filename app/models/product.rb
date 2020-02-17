class Product < ApplicationRecord
  searchable do
    text :title, :description, :country, :tags
    double :price
    time :created_at
  end
end
