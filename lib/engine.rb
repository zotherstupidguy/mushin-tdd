module Mushin
  class Engine

    @@book_rules = []

    def self.add_rule rule
      @@book_rules << rule
    end

    def self.get_rules
      # load or require_relative certain ruby books, done to be least invasive 
      @@book_rules
    end

    def initialize env, book
      @env_id 		= env[:id]
      @env_rules 	= env[:rules]
      @book_rules	= book[:rules]
      match 
    end

    def match
      @@book_rules.each do |rule|
	if rule[:conditions] == "my provided conditions" then 
	  # apply rule[:actions]
	end
      end
      @book_rules[@env_rules.to_sym]
    end

    #def self.set_rules
    # loads or require certain ruby books
    # book ||= {:rules => {:some_data => "some rules(conditions and actions)", :x => "dfdf", :y => "dfdf"}}
    # Book.new("location of the book file") will return an array or hash of the rules
    #end

    def self.run env
      env[:book_rules] = get_rules
      new(env, @@rules)
    end
  end
end 

#Mushin::Engine.run({:id => "myid", :rules => "some_data"})
