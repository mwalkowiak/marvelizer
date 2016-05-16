require_relative 'request'

module Marvelizer
  class Client
    include Marvelizer::Request

    attr_accessor :public_key, :private_key

    def initialize(attrs)
      validate_params(attrs)
      configure do |config|
        config.public_key = attrs.fetch(:public_key)
        config.private_key = attrs.fetch(:private_key)
      end
    end

    def validate_params(attrs)
      [:public_key, :private_key].each do |key|
        raise StandardError, "Please provide #{key} param" unless attrs[key]
      end
    end

    # fetches lists of characters
    def characters(options = {})
      # v1/public/characters
      get_request('characters', options)
    end

    # fetches a single character by id
    def character(id, options = {})
      # v1/public/characters/{characterId}
      get_request("characters/#{id}", options)
    end
  end
end
