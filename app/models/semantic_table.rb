class SemanticTable
  
  def initialize
    @hash = {}    
  end
  
  def declare_variable(identifier,type,scope,value = nil)
    return false unless @hash[identifier+scope.to_s] == nil
    
    line = SemanticTableLine.new type, scope , value
    @hash[identifier+scope.to_s] = line
    
    return true
  end
  
  def delete_by_scope(scope)
    @hash.each { |key,value|
      if value.scope == scope
        @hash.delete key
      end
    }
  end
  
  def get_type(name,scope)
     result = nil
     while(scope > 0 && result == nil)
      result = @hash[name+scope.to_s]
    end
    return result.type if result != nil 
  end
  
  def declared?(name,scope)
    result = false
    while(scope > 0)
      result = result || @hash[name+scope.to_s] != nil
      scope = scope - 1
    end
 
    return result
  end
  
end