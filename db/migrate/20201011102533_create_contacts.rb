class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :phone, default: ''
      t.string :email, default: ''
      t.string :instagram, default: ''
      t.timestamps
    end
  end
end
