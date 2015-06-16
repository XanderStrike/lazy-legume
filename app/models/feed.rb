class Feed < ActiveRecord::Base
  has_many :rules

  validates :name, presence: true
  validates :url,  presence: true
end
