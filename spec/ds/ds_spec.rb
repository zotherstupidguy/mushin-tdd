require_relative './../../lib/ds/ds'
require_relative './../helper'

describe 'ds' do 
  before do
    app 	= proc{[200,{},['.']]}
    @stack = Mushin::Persistence::DS.new(app, opts={},params={})
    @env = {:id => "123", :data => "very important data"} 
  end

  it 'is a middleware' do 
    @stack.must_respond_to :call
  end

  it 'is used to store domain instances enviroment objects before and after they hit the stack' do 
    @stack.call(@env)[:id].must_equal '123'
    @stack.call(@env)[:data].must_equal 'very important data'
  end
end
