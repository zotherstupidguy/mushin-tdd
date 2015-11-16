require 'logger' 
    $logger = Logger.new(STDOUT)
    module Mushin
      module Book
	def rule &block
	  @rule 		= {}
	  @rule[:conditions] = []
	  @rule[:actions] 	= []
	  def condition c
	    @rule[:conditions] << c
	    $l.info "condition #{c} is added"
	  end
	  def action a
	    @rule[:actions] << a
	    $l.info "action #{a} is added"
	  end
	  yield
	  $l.info "this rule is #{@rule}"
	  Mushin::Engine.add_rule @rule
	end
      end
    end

module MyCookBook
  extend Mushin::Book

  rule do
    condition :a_condition
    condition :b_condition
    condition :c_condition

    action :a_action
    action :b_action
    action :c_action
  end

  rule do
    condition :d_condition
    condition :e_condition
    condition :f_condition

    action :d_action
    action :e_action
    action :f_action
  end
end

