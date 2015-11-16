require_relative './redis'

module Mushin 
  module Persistence
    class DS 

      def initialize(app, opts={}, params={})
	@app = app
	@opts = opts
	@params = params
	@redis_ds = Mushin::Persistence::RedisDS.new
      end

      def call(env)
	@id = env[:id]
	if @redis_ds.exists? @id 
	  env[:id] = @redis_ds.get(@id)[:id]
	  env[:data] = @redis_ds.get(@id)[:data]
	  $logger.info("domain env object exists in the database") 
	else 
	  @redis_ds.set(@id, env[:data])
	  $logger.info("domain env object DOESNOT exist in the database") 
	end
	@app.call(env) # calls up the stack
	@redis_ds.set(@id, env)
	env
      end

    end
  end
end
