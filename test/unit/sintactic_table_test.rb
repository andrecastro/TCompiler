require 'test_helper'

class SintacticTableTest < ActiveSupport::TestCase

  test "create_table" do
    grammar = DefinedGrammar.get
    s_table = SintacticTable.new(grammar)
    
    s_table.table.each do |key|
      puts key
    end
    
  end
end
