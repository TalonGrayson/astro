class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :device_id
      t.integer :user_id
      t.boolean :active, default: false
    end
  end
end
