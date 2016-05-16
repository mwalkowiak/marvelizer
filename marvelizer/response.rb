require 'hashie'

module Marvelizer
  class Response < Hash
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::KeyConversion
    include Hashie::Extensions::MethodAccess
    include Hashie::Extensions::IndifferentAccess

    attr_reader :raw_response

    def self.create(response)
      case response.code.to_i
        when 200 then Response.new(JSON.parse(response.body))
        when 304 then NotModifiedResponse.new(response)
        else ErrorResponse.new(response)
      end
    end

    def initialize(raw)
      @raw_response = raw
      super(raw)
    end
  end

  class ErrorResponse < Response
    def initialize(response)
      super({
        status: 'Error Response',
        code: response.code,
        data: JSON.parse(response.body)
      })
    end
  end

  class NotModifiedResponse < Response
    def initialize(response)
      super({
        status: 'Not Modified',
        code: 304,
        data: {},
        etag: response.headers['etag']
      })
    end
  end
end
