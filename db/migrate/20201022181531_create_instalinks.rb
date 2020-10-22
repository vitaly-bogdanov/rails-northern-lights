class CreateInstalinks < ActiveRecord::Migration[5.2]
  def change
    create_table :instalinks do |t|

      t.timestamps
    end
  end
end
