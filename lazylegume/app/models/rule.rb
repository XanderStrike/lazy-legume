class Rule < ActiveRecord::Base
  belongs_to :show
  belongs_to :feed
end
