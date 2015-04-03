class Episode < ActiveRecord::Base
  validates :name, presence: true
  validates :link, presence: true
  validates :season, presence: true
  validates :ep_in_season, presence: true

  before_validation :parse_season_code

  belongs_to :show

  def parse_season_code
    return unless season.blank? || ep_in_season.blank?
    code = self.name.scan(/S\d{2}E\d{2}/i).tap {|c| return if c.empty? }.first.scan(/\d{2}/)
    self.season = code.first.to_i
    self.ep_in_season = code.last.to_i
  end

  # def download
  #   `wget #{@link} -O #{DOWNLOAD_LOCATION}/#{name.gsub(' ', '.')}.torrent`
  # end
end
