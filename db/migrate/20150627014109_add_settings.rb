class AddSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :key, null: false
      t.string :str
      t.integer :int
      t.boolean :bool

      t.timestamps
    end
  end
end
