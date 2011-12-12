require 'test_helper'
require 'ruby-debug'

class TRecogTest < ActiveSupport::TestCase

  test "should recognize" do

    t_lex = TLex.new("programa.txt")

    grammar = DefinedGrammar.get

    s_table = SintacticTable.new(grammar)
    
    t_rec = TRecog.new(s_table,t_lex)
    
    puts t_rec.recognize
  end

end
