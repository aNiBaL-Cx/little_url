class CreateMinifiedLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :minified_links do |t|
      t.string :original_url
      t.string :url_key

      t.timestamps
    end
  end
end
