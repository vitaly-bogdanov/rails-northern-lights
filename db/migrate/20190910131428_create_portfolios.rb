class CreatePortfolios < ActiveRecord::Migration[5.2]
  def change
    create_table :portfolios do |t|
      t.string :picture
      t.string :name
      t.string :description
      t.timestamps
    end
  end
end
