class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.belongs_to :category
      t.string     :picture
      t.string     :name
      t.integer    :price
      t.text       :description
      t.string     :preview
      t.text       :keywords
      t.boolean    :unique
      t.timestamps
    end
  end
end
