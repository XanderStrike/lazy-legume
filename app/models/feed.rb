class Feed < ActiveRecord::Base
  has_many :rules
end
