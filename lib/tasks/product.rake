namespace :product do
  desc "importing product json file"
  task import_json: :environment do
    Dir.glob(Rails.root.to_s + "/SpocketProducts.json") do |fname|
      file = File.open fname
      data = JSON.load file
      data.each do |row|
        Product.create!(
          title: row['title'],
          description: row['description'],
          country: row['country'],
          tags: row['tags'],
          price: row['price']
        )
      end
      file.close
    end
  end
end
