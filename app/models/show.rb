class Show < ActiveRecord::Base
  has_many :rules, dependent: :destroy
  has_many :episodes, dependent: :destroy
end
