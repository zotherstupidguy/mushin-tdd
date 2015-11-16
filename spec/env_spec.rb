require_relative './helper'
require_relative  './../lib/env.rb'

describe 'Env' do 
  before do 
    require 'redis'
    class Mushin::Engine
      def self.run env
	r = Redis.new
	if r.get(env.id) then
	  return Marshal.load(r.get(env.id))
	else
	  r.set(env.id.to_s, Marshal.dump(env))
	  return Marshal.load(r.get(env.id))
	end
      end
    end
  end

  after do 
    #TODO clean up the Mushin::Engine class as not to conflic with other testcases that use the real Engine class with middleware more complicated middlewares 
  end

  #it 'provides a standard mushin dsl for application developers to enforce rules, i.e. context and activity' do 
  it 'sets an domain_instance object with a given id' do 
    `redis-cli flushall`
    @domain_obj = Mushin::Env.set 'myid' do 
      rule [[:c1, :c1,:c1], [:c2, :c2, :c2]]
      rule [[:c3, :c3,:c3], [:c4, :c4, :c4]]
      rule [[:c5, :c5,:c5], [:c6, :c6, :c6]]

    end
    @domain_obj.env[:id].must_equal 'myid'
    @domain_obj.env[:rules].must_equal [[[:c1, :c1,:c1], [:c2, :c2, :c2]], 
					[[:c3, :c3,:c3], [:c4, :c4, :c4]], 
					[[:c5, :c5,:c5], [:c6, :c6, :c6]]]
  end

  it 'gets a domain_instance object via its id' do 
    `redis-cli flushall`
    ### Mushin::Env.set
    @domain_obj = Mushin::Env.set 'myid' do 
      rule [[:c1, :c1,:c1], [:c2, :c2, :c2]]
      rule [[:c3, :c3,:c3], [:c4, :c4, :c4]]
      rule [[:c5, :c5,:c5], [:c6, :c6, :c6]]
    end
    @domain_obj.env[:id].must_equal 'myid'

    @domain_obj.env[:rules].must_equal [[[:c1, :c1,:c1], [:c2, :c2, :c2]], 
					[[:c3, :c3,:c3], [:c4, :c4, :c4]], 
					[[:c5, :c5,:c5], [:c6, :c6, :c6]]]
    ### Mushin::Env.get
    @domain_obj = Mushin::Env.get('myid')
    @domain_obj.env[:id].must_equal 'myid'
    @domain_obj.env[:rules].must_equal [[[:c1, :c1,:c1], [:c2, :c2, :c2]], 
					[[:c3, :c3,:c3], [:c4, :c4, :c4]], 
					[[:c5, :c5,:c5], [:c6, :c6, :c6]]]
  end

  it 'provides a way for domain middlewares to set their opts and params' do 
    skip
  end
end
