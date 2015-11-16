require_relative './../helper'
require_relative './../../lib/ds/redis'

describe 'mushin' do 

  before do 
    require 'logger' 
    $logger = Logger.new(STDOUT)
  end


  describe Mushin::Persistence::RedisDS do 

    before do 
      class ValueObject
	attr_accessor :data
      end
      @value_obj 	= ValueObject.new
      @id 		= '123'

      @ds 		= Mushin::Persistence::RedisDS.new
      @ds.id 		= @id
      @ds.value_obj 	= @value_obj
    end 

    it 'takes a key id' do 
      @ds.id.must_equal '123'
      @ds.id.wont_equal 'someother value'
    end

    it 'takes an value object' do 
      @value_obj.data = 'important data' 
      @ds.value_obj = @value_obj 

      @ds.value_obj.data.must_equal 'important data' 
    end

    it 'takes an id and a value object and sets the persistence' do
      `redis-cli flushall`
      @value_obj.data = 'important data' 
      @ds.value_obj = @value_obj 

      @ds.set.must_equal 'OK' 
      Redis.new.get(@id).must_equal Marshal.dump(@value_obj)
    end

    it 'gets a value object with the given key id' do
      `redis-cli flushall`
      @value_obj.data = 'important data' 
      @ds.value_obj = @value_obj 

      @ds.set.must_equal 'OK' 
      Redis.new.get(@id).must_equal Marshal.dump(@value_obj)
      @ds.get(@id).data.must_equal (@value_obj.data)
    end

    it 'checks if a certain value object exists by its id key' do 
      `redis-cli flushall`
      @value_obj.data = 'important data' 
      @ds.value_obj = @value_obj 
      @ds.set.must_equal 'OK' 

      @ds.exists?('123456').must_equal false 
      @ds.exists?('123').must_equal true 
    end
  end
end
