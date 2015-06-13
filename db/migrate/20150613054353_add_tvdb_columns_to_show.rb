class AddTvdbColumnsToShow < ActiveRecord::Migration
  def change
    add_column :shows, :poster,         :string,  null: true
    add_column :shows, :overview,       :string,  null: true
    add_column :shows, :actors,         :string,  null: true
    add_column :shows, :first_aired,    :date,    null: true
    add_column :shows, :rating,         :string,  null: true
    add_column :shows, :status,         :string,  null: true
    add_column :shows, :airs_dayofweek, :string,  null: true
    add_column :shows, :airs_time,      :string,  null: true
    add_column :shows, :genre,          :string,  null: true
    add_column :shows, :tvdb_id,        :integer, null: true
  end
end
