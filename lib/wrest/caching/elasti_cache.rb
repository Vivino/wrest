begin
  gem 'dalli-elasticache', '~> 0'
rescue Gem::LoadError => e
  Wrest.logger.debug "dalli-elasticache ~> 0 not found. The dalli-elasticache gem is necessary to use the elasticache caching back-end."
  raise e
end

require 'dalli-elasticache'

module Wrest::Caching
  class ElastiCache

    def initialize(endpoint=nil, options={})
      @elasticache = Dalli::ElastiCache.new(endpoint, options)
    end

    def [](key)
      @elasticache.get(key)
    end

    def []=(key, value)
      @elasticache.set(key, value)
    end

    # should be compatible with Hash - return value of the deleted element.
    def delete(key)
      value = self[key]

      @elasticache.delete key

      return value
    end
  end
end
