require 'singleton'
require 'forwardable'
class HashingService
  include Singleton
  extend Forwardable
  def initialize
    #@hashids = Hashids.new(Rails.application.credentials.secret_key_base)
    # the key is hardcoded for demonstration purposes
    @hashids = Hashids.new '68e3b0eaebfa83338f69d66552221841aa380e4860c4493bf1b6edf2bc73ecc1a5ae43be5c57f27919bf6b7a3e102bd6a2c2c6b6b77e9fccb31c88be0716b638'
  end

  def_delegators :@hashids, :encode, :decode

end
