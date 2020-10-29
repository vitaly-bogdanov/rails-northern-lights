class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name, null: false, default: ''
      t.text :description, null: false, default: ''
      t.text :keywords, null: false, default: ''
      t.integer :views, null: false, default: 0
      t.timestamps
    end
  end
end
