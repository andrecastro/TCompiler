class ProductionRule
  
  attr_accessor :left
  attr_accessor :right
  
  def initialize(left,right)
    @left = left
    @right = right
  end
 
  def to_s
    "#{left.to_s} => #{right.to_s}"
  end
 
end