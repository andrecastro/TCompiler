#encoding: UTF-8
require 'test_helper'

class TokenizerTest < ActiveSupport::TestCase
  
  
  def test_tokenize
    
  end
  
  
  def test_do_process
    t = Tokenizer.new("favorite-people.txt")
    puts t.tokens
  end
  
  
end
