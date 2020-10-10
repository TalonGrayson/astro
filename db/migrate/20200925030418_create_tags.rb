class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :tag_hex
      t.string :origin
      t.string :variety
      t.string :name
      t.string :light_rgb
      t.integer :health
      t.integer :defence
      t.integer :attack
      t.integer :speed
      t.datetime :last_seen
      t.boolean :deleted

      t.timestamps
    end
  end
end
