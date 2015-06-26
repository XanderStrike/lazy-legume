class Rule < ActiveRecord::Base
  belongs_to :show
  belongs_to :feed

  class << self
    def build_for_show(show, params)
      params[:keywords] = tokenize_string(show.name)
      params[:regex] = params[:keywords].split(' ').join('.*')

      params[:regex] += '.*' + params[:quality] unless params[:quality].blank?

      Rule.create({ show: show, feed: Feed.first }.merge(params))
    end

    private

    def tokenize_string(str)
      str.downcase.split(/\W/).reject(&:blank?).join(' ')
    end
  end
end
