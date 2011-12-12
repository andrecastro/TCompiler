class ContextFreeGrammar
  
  attr_accessor :variables
  attr_accessor :terminals
  attr_accessor :rules
  attr_accessor :initial_symbol
  attr_accessor :delimiter_symbol
  
  def initialize
    @variables = []
    @terminals = []
    @rules = []
  end
  
  def rules_by_left(left)
    rules = []
    @rules.each do |rule|
      rules << rule if rule.left == left
    end
    return rules
  end

  def rule_that_contains_on_right(symbol)
    rules = []
    @rules.each do |rule|
      rules << rule if rule.right.include?(symbol)
    end
    rules
  end


end