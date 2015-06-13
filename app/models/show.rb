class Show < ActiveRecord::Base
  has_many :rules, dependent: :destroy
  has_many :episodes, dependent: :destroy

  validates :name,    presence: true
  validates :tvdb_id, presence: true

  def cast_list
    parse_to_array(actors)[0..5].join(', ') rescue nil
  end

  def genre_list
    parse_to_array(genre).join("<br>") rescue nil
  end

  private

  def parse_to_array stringified_list
    stringified_list.tr('[]"', '').split(', ')
  end
end
