class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.belongs_to :category
      t.string :name, null: false, default: ''
      t.string :picture, null: true
      t.integer :price, null: false, default: 0
      t.text :description, null: false, default: ''
      t.string :preview, null: false, default: ''
      t.text :keywords, null: false, default: ''
      t.boolean :available, default: true
      t.boolean :unique, null: false, default: false
      t.timestamps
    end
    add_index :products, :name # для ускорения поиска
  end
end
