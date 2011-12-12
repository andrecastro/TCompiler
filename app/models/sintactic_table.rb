class SintacticTable
  
  attr_accessor :table
  attr_accessor :grammar
 
  def initialize(grammar)
    @table = {}
    @grammar = grammar
    @current_rule = nil
    create_table
  end
  
  
  def create_table
    # initialize_table
    grammar.rules.each do |rule|
      @current_rule = rule
      process_rule(rule)  
    end   
  end
  
  def initialize_table
    grammar.variables.each do |var|
      grammar.terminals.each do |ter|
        table[var+ter] = nil
      end
      table[var+grammar.delimiter_symbol] = nil
    end
  end
  
  def process_rule(rule)
    first_symbol = rule.right[0]
    
    if grammar.terminals.include?(first_symbol)
       table[@current_rule.left + first_symbol] = @current_rule
    else   
      if grammar.variables.include?(first_symbol)
        do_left_process(rule)
      else
        if rule.left == "F'"
          table[@current_rule.left + "}"] = @current_rule
          return
        end
        # debugger
        verify_right_symbols(rule) if first_symbol == "@" 
      end   
    end
  end

  def do_left_process(rule)
    first_symbol = rule.right[0]
    grammar.rules_by_left(first_symbol).each do |r|
      process_rule(r)
    end
  end
  
  def verify_right_symbols(rule)
    symbol_direct_right(rule)  
    symbol_indirect_right(rule)    
  end

  def symbol_direct_right(rule)
    grammar.rule_that_contains_on_right(rule.left).each do |r|
      symbols = get_symbols_on_right(rule.left,r)
      symbols.each do |symbol|
        if grammar.terminals.include?(symbol)
          table[@current_rule.left + symbol] = @current_rule
        else
          grammar.rules_by_left(symbol).each do |r2|
            process_rule(r2)
          end    
        end
      end
    end
  end
  
  def symbol_indirect_right(rule)
    grammar.rule_that_contains_on_right(rule.left).each do |r|
      table[@current_rule.left + grammar.delimiter_symbol] = @current_rule if r.left == grammar.initial_symbol
      symbol_direct_right(r)
    end   
  end
  
  def get_symbols_on_right(symbol,r)
    symbols = []
    return symbols if r.right.last == symbol
    symbols = r.right.last(r.right.length - (r.right.index(symbol)+1))       
  end
 
end