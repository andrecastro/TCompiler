class TLex 
  
  attr_accessor :tokens  
  
  def initialize(filename)
    @tokenizer = Tokenizer.new(filename)
    @tokens = @tokenizer.tokens
    @tokens << Token.new("$","DELIMITER",0)
  end
  
  def get_tokens
    @tokenizer.tokens
  end
  
  def next_token
    token = @tokens.reverse!.pop
    @tokens.reverse!
    return token    
  end
  
  def to_s
    self.tokens
  end
  
end
