class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table  :addresses do |t|

      t.string      :first_name,          null: false
      t.string      :first_name_kana,     null: false
      t.string      :last_name,           null: false
      t.string      :last_name_kana,      null: false

      t.string      :postal_code,         null: false
      t.string      :prefectur,           null: false
      t.string      :city,                null: false
      t.string      :house_number,        null: false
      t.string      :apartment,           null: false
      t.string      :phone,               null: false
      t.references  :user
      t.timestamps

    end
  end
end