class Rule < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :regex
      t.integer :show_id, null: false
      t.integer :feed_id, null: false

      t.timestamps
    end
  end
end
