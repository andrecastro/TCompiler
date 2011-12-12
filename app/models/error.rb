class Error
  attr_accessor :value
  attr_accessor :line
  
  def initialize(value,line)
    @value = value
    @line = line
  end
  
end