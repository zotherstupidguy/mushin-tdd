module Mushin
  class Env

    attr_accessor :id, :rule , :env

    def initialize id, &block
      @env	 	= {}
      @env[:rules] 	= []
      @id 		= id
      @env[:id] 	= @id
      instance_eval &block if block_given? 
    end

    def rule(conditions = [])
      @env[:rules] << conditions
    end

    def self.set id, &block
      domain_instance = Mushin::Env.new id, &block
      Mushin::Engine.run domain_instance
    end

    # run engine, give the env to the engine, 
    # engine will return the env_instance after it hit all the middlewares including the database middleware.
    # because domain_instance.env[:rules] is empty as there is no block; the Engine stack will only be of one middleware
    # , the Mushin::Presistance::DS middleware
    # Mushin::Engine.run domain_instance 
    def self.get id
      domain_instance = Mushin::Env.new id
      Mushin::Engine.run domain_instance
    end

  end
end

=begin
    def self.set id
      self.new id
      #Mushin::Persistence::RedisDS.new.set @id 
    end
    def self.get id
      self.new id
      #Mushin::Persistence::RedisDS.new.get @id 
    end
=end
=begin
# Each Domain Framework got its own Env object in the application space. 
# In this manner the application can easily set and get enviroment objects
#
module Mushin
  class Env

    attr_accessor :id, :current_context_title, :activities

    def initialize
      @id 			= ''
      @current_context_title 	= ''
      @activities 		= []
    end

    def set id, &block
      @id = id.to_s + 'mushin'
      def context current_context_title, &block
	@current_context_title 	= current_context_title  
	@activities 		= []  
	def activity current_activity_title
	  @activities << current_activity_title 
	end
	instance_eval(&block)
      end
      instance_eval(&block)
      #@activities.uniq.each do |current_activity_title| 
      @activities.each do |current_activity_title| 
	#GameOn::Engine.run @id, @current_context_title, current_activity_title 
	$logger.info("Domain Framework Engine.run: #{@id}, #{@current_context_title}, #{current_activity_title}") 
      end
      @activities = [] # reset the activities 
      return Mushin::Persistence::DS.load @id 
    end

    def get id
      @id = id.to_s + 'mushin' 
      #TODO make a git issue for some encryption method based on a configurable app key
      Mushin::Persistence::DS.load @id 
    end

    def self.set id, &block
      e = Env.new
      e.set id, &block
    end

    def self.get id
      e = Env.new
      e.get id
    end
  end
end
=end
