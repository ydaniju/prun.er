# == Schema Information
#
# Table name: links
#
#  id             :integer          not null, primary key
#  url_input      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  shortened_link :string
#  user_id        :integer
#  visits         :integer
#  enabled        :boolean          default(TRUE)
#  erased         :boolean
#

class Link < ActiveRecord::Base
  URL_REGEX =
    %r{\A(https?:\/\/)?([a-z0-9]+\.)?[a-z0-9\-]+\.[a-z]+.+[^\W\_]\z}

  belongs_to :user, counter_cache: true

  scope :top_links, -> { order(visits: :desc).limit(9) }
  scope :latest_links, -> { order(created_at: :desc).limit(9) }

  before_create :link_shortener

  validates :url_input, format: { with: URL_REGEX }

  after_initialize :init_visits

  def init_visits
    self.visits ||= 0
  end

  def link_shortener
    self.shortened_link = SecureRandom.urlsafe_base64(5)
  end
end
