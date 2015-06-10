class CreateEpisode < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :name, null: false
      t.integer :season, null: false
      t.integer :ep_in_season, null: false
      t.string :link, null: false
      t.integer :show_id, null: false
      t.boolean :downloaded, default: false, null: false
      t.timestamps
    end
  end
end
