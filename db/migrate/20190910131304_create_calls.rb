class CreateCalls < ActiveRecord::Migration[5.2]
  def change
    create_table :calls do |t|
      t.string :name
      t.string :telephone
      t.string :timezone
      t.text :notes
      t.boolean :completed, default: false
      t.boolean :saved, default: false
      t.timestamps
    end
  end
end
