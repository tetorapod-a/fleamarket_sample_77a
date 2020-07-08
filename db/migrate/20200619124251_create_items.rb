class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name,                       null: false
      t.text :detail,                       null: false
      t.integer :price,                      null: false
      t.integer :status_id,                 null: false
      t.integer :postage_id,                null: false
      t.integer :shipping_day_id,           null: false
      t.integer :shipping_method_id,        null: false
      t.integer :prefecture_id,             null: false
      t.string :brand
      t.references :category,               null: false
      t.references :buyer                 
      t.references :seller,                 null: false
      t.timestamps
    end
      add_index :items, :name

      # t.integer :status_id(active_hash)
    
  end
end