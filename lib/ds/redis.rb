require "redis"

module Mushin 
  module Persistence
    class RedisDS
      attr_accessor :id, :value_obj
      def initialize(opts={}, params={})
	#@id = params[:id]
	#@value_obj = params[:value_obj]
	@redis = Redis.new #opts to take a different redis server
      end

      def set(id = @id, value_obj = @value_obj) 
	@redis.set(id, Marshal.dump(value_obj))
      end

      def get(id = @id)
	Marshal.load(@redis.get(id))
	#@redis.get(id)
      end

      def exists?(id)
	if @redis.get(id).nil? then
	  return false
	else 
	  return true
	end
      end
    end
  end
end
