class Setting < ActiveRecord::Base
  # setting lookup
  def self.method_missing(m)
    where(key: m).first
  end
end
