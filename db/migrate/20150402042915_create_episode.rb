class CreateEpisode < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :name
      t.integer :season
      t.integer :ep_in_season
      t.string :link
      t.integer :show_id
      t.boolean :downloaded, default: false
      t.timestamps
    end
  end
end
