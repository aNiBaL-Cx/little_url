class MinifiedLink < ApplicationRecord
  validates :original_url, presence: true
  validate :validate_url
  before_validation do |record|
    record.original_url=full_url
  end

  after_create do |record|
    record.update_column(:url_key, HashingService.instance.encode(record.id))
  end

  def target_url
    sanitized_url
  end

  private
  def full_url
    #original_url&.downcase&.starts_with?('http') ? original_url : URI::HTTP.build({host: original_url}).to_s
    original_url&.downcase&.starts_with?('http') ? original_url : "http://#{original_url}"
  end

  def valid_url?
    !!original_url.match(/(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix)
  end

  def validate_url
    errors.add(:original_url, 'URL inválido!') unless valid_url?
  end

end
