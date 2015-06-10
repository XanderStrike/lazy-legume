class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
