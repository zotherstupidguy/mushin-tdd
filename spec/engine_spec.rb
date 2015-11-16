require_relative './helper'
require_relative './../lib/engine'

describe 'mushin' do 

  before do 
    module Mushin
      class Engine

	@@rules = [ 
	  {:conditions=>[:a, :b, :c], :actions=>[:a, :b, :c]}, 
	  {:conditions=>[:deadpool, :s, :e], :actions=>[:ninja, :hulks, :spiderman]}, 
	  {:conditions=>[:a, :b, :c], :actions=>[:a, :b, :c]}, 
	  {:conditions=>[:supermananal, :ninjaass, :cocok], :actions=>[[[:dfdf, :ddfadsf, :Dfasf], [:dfdf, :ddfadsf, :Dfasf]], :hfsfasfasflks, :spidsfsfsafasfn]} 
	]

      end
    end

    @env = {:id => "12345", 
	    :rules => [
	      [[:c1, :c1, :c1], [:c2, :c2, :c2]], 
	      [[:c3, :c3, :c3], [:c4, :c4, :c4]], 
	      [[:c5, :c5, :c5], [:c6, :c6, :c6]]]
    }
  end

  describe Mushin::Engine do 

    before do 
      #@engine = Mushin::Engine.new
      #@engine.conditions = 
    end

    it 'matches a number of conditions with rules and certain actions' do
      Mushin::Engine.run(@env)
    end

    it 'acquires the rules from a book' do

    end

    it 'got a run method' do
      Mushin::Engine.methods.must_include :run
    end

  end
end
