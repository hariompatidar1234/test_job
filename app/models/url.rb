class Url < ApplicationRecord
  validates :long_url, presence: true, on: :create

  belongs_to :user
  before_create :generate_short_url, :sanitize

  def generate_short_url
    rand(36**8).to_s(36)
  end

  def sanitize
    self.long_url.strip!
    self.sanitize_url = "http://" + self.long_url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")
   end
end
