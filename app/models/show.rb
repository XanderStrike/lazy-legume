class Show < ActiveRecord::Base
  has_many :rules
  has_many :episodes
end
