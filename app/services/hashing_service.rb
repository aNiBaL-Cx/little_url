require 'singleton'
require 'forwardable'
class HashingService
  include Singleton
  extend Forwardable
  def initialize
    @hashids = Hashids.new(Rails.application.credentials.secret_key_base)
  end

  def_delegators :@hashids, :encode, :decode

end