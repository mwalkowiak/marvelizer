require_relative 'marvelizer/client'

module Marvelizer
  class << self
    # Simplified router to start with client
    def new(attrs)
      @client ||= Marvelizer::Client.new(attrs)
    end
  end
end
