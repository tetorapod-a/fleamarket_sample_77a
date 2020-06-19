class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name,                              null: false
      t.text :detail,                              null: false
      t.string :price,                             null: false
      t.integer :status_id(active_hash),           null: false
      t.integer :postage_id(active_hash),          null: false
      t.integer :shipping_day_id(active_hash),     null: false
      t.integer :shipping_method_id(active_hash),  null: false
      t.integer :prefecture_id(active_hash),       null: false
      t.string :brand
      t.references :category,                      null: false, foreign_key: true
      t.references :buyer,                         foreign_key: true
      t.references :seller,                        null: false, foreign_key: true
      t.timestamps
    end
  end
end