class SemanticTableLine
  
  attr_accessor :type
  attr_accessor :scope
  attr_accessor :value
  
  def initialize(type,scope,value)
    @type = type
    @scope = scope
    @value = value
  end
  
end