class Show < ActiveRecord::Base
  has_many :rules, dependent: :destroy
  has_many :episodes, dependent: :destroy

  validates :name,    presence: true
  validates :tvdb_id, presence: true

  TVDB_ATTRIBUTES = %w(poster name actors overview first_aired rating status airs_dayofweek airs_time genre)

  def cast_list
    parse_to_array(actors)[0..5].join(', ') rescue nil
  end

  def genre_list
    parse_to_array(genre).join('<br>') rescue nil
  end

  def poster_path
    "http://thetvdb.com/banners/#{ poster }"
  end

  def update_info
    new_info = Tvdb.new.lookup(tvdb_id)
    new_attrs = TVDB_ATTRIBUTES.each_with_object({}) do |at, hash|
      hash[at] = new_info.send(at).to_s
    end

    update_attributes(new_attrs)
  end

  private

  def parse_to_array(stringified_list)
    stringified_list.tr('[]"', '').split(', ')
  end
end
