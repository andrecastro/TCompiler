class TSemantic
  attr_accessor :scope
  
  def initialize
    @tokens = Array.new
    @semantic_table = SemanticTable.new
  end
  
  def add_token(token)
    @tokens << token
  end
  
  def analize_expression
    case @tokens[0].type
    when SymbolTable::RESERVED_WORDS["int"] , SymbolTable::RESERVED_WORDS["double"] , SymbolTable::RESERVED_WORDS["char"]
        return do_declaration
    when SymbolTable::IDENTIFIER
        return do_usege_variable
    end
  end
  
  def has_tokens?
    return !@tokens.empty?
  end
  
  def clear_tokens
    @tokens.clear
  end
  
  def delete_scope
    @semantic_table.delete_by_scope(scope)
  end

private 

  def do_declaration
     type = @tokens[0].type

     if @tokens[1] != nil && @tokens[1].type == SymbolTable::IDENTIFIER
       name = @tokens[1].value
     else
       return { :status => false,:message => "erro" }
     end
     
     value = nil 
     
     if @tokens[2] != nil
       if @tokens[2].type == SymbolTable::OPERATORS["="]
         value = resolve_value
       end
     end
     
     response = @semantic_table.declare_variable name, type , scope, value
     
     if response == false
       return { :status => false , :message => "Erro na linha: #{@tokens[1].line} -> Variavel '#{name}' declarada duas vezes no mesmo bloco"}
     end
     
     return { :status => true , :message => "ok"}
  end
  
  def do_usege_variable(variable)
    result = true
    
    type = @semantic_table.get_type(variable.name,@scope)
    
    @tokens.each do |token|
      case type
      when SymbolTable::IDENTIFIER
        result = result && @semantic_table.declared?(token.value,scope)
        token.type == type
      when SymbolTable::IDENTIFIER
      
      if token.type ==  SymbolTable::IDENTIFIER
        result = result && @semantic_table.declared?(token.value,scope)
      end
      
      return { :status => false , :message => "Erro na linha: #{token.line} -> Variavel '#{token.value}' nao declarada" } if result == false
    end
    
    
    
    return { :status => true , :message => "ok" }
  end
  
  def resolve_value
    
  end
  
end