class Token < ActiveRecord::Base
  
  attr_accessor :value
  attr_accessor :type
  attr_accessor :line
  
  def initialize(value,type,line)
    @value = value
    @type = type
    @line = line
  end
  
  def to_s
    "value: #{value} type: #{type} line: #{line}"
  end
  
end
