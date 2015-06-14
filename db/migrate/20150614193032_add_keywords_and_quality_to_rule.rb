class AddKeywordsAndQualityToRule < ActiveRecord::Migration
  def change
    add_column :rules, :keywords, :string, null: true
    add_column :rules, :quality, :string, null: true
  end
end
