require 'test_helper'
require 'ruby-debug'

class TRecogTest < ActiveSupport::TestCase

  test "should recognize" do

    t_lex = TLex.new("programa.txt")

    grammar = DefinedGrammar.get

    s_table = SintacticTable.new(grammar)
    
    t_rec = TRecog.new(s_table,t_lex)
    
    response = t_rec.recognize
    
    puts response[:status] && t_rec.semantic_errors.empty?
    puts "line #{response[:line]}"
  end

end
