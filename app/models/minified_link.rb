class MinifiedLink < ApplicationRecord
  validates :original_url, presence: true
  validate :validate_url
  before_validation do |record|
    record.original_url = full_url unless record.original_url.blank?
  end

  after_create do |record|
    record.update_column(:url_key, HashingService.instance.encode(record.id))
  end

  def minified_path
    HashingService.instance.encode(id)
  end

  scope :search_by_url_key, ->(search_id) {  find_by(id: HashingService.instance.decode(search_id)[0]) }

  private
  def full_url
    original_url&.downcase&.starts_with?('http') ? original_url : "http://#{original_url}"
  end

  def valid_url?
    !!"#{original_url}".match(/(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix)
  end

  def validate_url
    errors.add(:original_url, 'URL inválido!') unless valid_url?
  end

end
