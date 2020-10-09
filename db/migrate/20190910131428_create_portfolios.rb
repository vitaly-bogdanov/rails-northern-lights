class CreatePortfolios < ActiveRecord::Migration[5.2]
  def change
    create_table :portfolios do |t|
      t.string :picture, null: true
      t.string :name, null: false, default: ''
      t.string :description, null: false, default: ''
      t.timestamps
    end
  end
end
