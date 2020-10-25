class CreateInstalinks < ActiveRecord::Migration[5.2]
  def change
    create_table :instalinks do |t|
      t.string :whatsapp, default: ''
      t.string :telegram, default: '' 
      t.string :facebook, default: ''

      t.timestamps
    end
  end
end
