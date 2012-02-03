class TRecog

  attr_accessor :sintatic_table
  attr_accessor :t_lex
  attr_accessor :semantic_errors
  
  def initialize(sintatic_table,t_lex)
    @sintatic_table = sintatic_table
    @t_lex = t_lex
    
    @scope = 0
    @semantic = TSemantic.new
    @semantic.scope = @scope
    @semantic_errors = []
    
    @stack = []
    @stack.push sintatic_table.grammar.delimiter_symbol
    @stack.push sintatic_table.grammar.initial_symbol
  end

  def recognize
    return {:status => true , :line => "-1" } if @stack.empty?
    token = t_lex.next_token
    
    return { :status => false , :line => "0" } if token == nil
    
    if @semantic.has_tokens? 
      if token.type == SymbolTable::OPERATORS[";"] || token.type == SymbolTable::OPERATORS["("] || token.type == SymbolTable::OPERATORS[")"]
        response = @semantic.analize_expression
        if response[:status] == false
          semantic_errors << response[:message]
        end
        @semantic.clear_tokens
      else
        @semantic.add_token token
      end
    end

    case token.type
    when SymbolTable::RESERVED_WORDS["int"] , SymbolTable::RESERVED_WORDS["double"] , SymbolTable::RESERVED_WORDS["char"]
      @semantic.add_token token
      token = Token.new(token.value,"TYPE",token.line)
    when SymbolTable::IDENTIFIER
      @semantic.add_token token if !@semantic.has_tokens?
    when SymbolTable::OPERATORS["{"]
      @scope = @scope + 1
      @semantic.scope = @scope
    when SymbolTable::OPERATORS["}"]
      @semantic.delete_scope
      @scope = @scope - 1
      @semantic.scope = @scope
    end

    proceed token
  end

  def proceed(token)
    symbol = @stack.pop

    if symbol == token.type
      return recognize
    end

    table_position = symbol + token.type
    rule = sintatic_table.table[table_position]
 
    return {:status => false  , :line => "Erro na linha: #{token.line} -> Sintaxe errada, proximo a #{token.value}" } if rule == nil

    rule.right.reverse.each do |r|
      @stack.push r unless r == "@"
    end

    return proceed(token)
  end

end
