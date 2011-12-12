class TRecog < ActiveRecord::Base

  attr_accessor :sintatic_table
  attr_accessor :t_lex
  def initialize(sintatic_table,t_lex)
    @sintatic_table = sintatic_table
    @t_lex = t_lex

    @stack = []
    @stack.push sintatic_table.grammar.delimiter_symbol
    @stack.push sintatic_table.grammar.initial_symbol
  end

  def recognize
    return true if @stack.empty?
    token = t_lex.next_token
    # debugger
    case token.type
    when SymbolTable::RESERVED_WORDS["int"] , SymbolTable::RESERVED_WORDS["double"] , SymbolTable::RESERVED_WORDS["char"]
      token = Token.new(token.value,"TYPE",token.line)
    end

    return false if token == nil
    proceed token.type
  end

  def proceed(token)
    symbol = @stack.pop

    if symbol == token
      return recognize
    end

    table_position = symbol + token
    rule = sintatic_table.table[table_position]

    return false if rule == nil

    rule.right.reverse.each do |r|
      @stack.push r unless r == "@"
    end

    return proceed(token)
  end

end
