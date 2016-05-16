require 'json'
require 'time'
require 'digest/md5'
require "net/http"
require "uri"

require_relative 'response'

module Marvelizer
  module Request
    attr_reader :public_key, :private_key

    MARVEL_API_BASE_URL = 'https://gateway.marvel.com/v1/public/'

    def configure
      yield self
    end

    def get_request(path, options = {})
      uri = URI.parse(MARVEL_API_BASE_URL) + path

      # We can pass optional params here using "options"
      params = options ? auth.merge(options) : auth
      uri.query = URI.encode_www_form(params)

      response = Net::HTTP.get_response(uri)
      Response.create(response)
    end

    def auth(ts = timestamp)
      { ts: ts, apikey: self.public_key, hash: hash(ts) }
    end

    def hash(ts)
      Digest::MD5.hexdigest(ts + self.private_key + self.public_key)
    end

    def timestamp
      Time.now.to_s
    end
  end
end
