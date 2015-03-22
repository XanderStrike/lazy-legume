class Rule < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :regex
      t.integer :show_id

      t.timestamps
    end
  end
end
