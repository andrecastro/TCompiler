class DefinedGrammar
  
  def self.get
    grammar = ContextFreeGrammar.new
    grammar.variables << "Z"
    grammar.variables << "B"
    grammar.variables << "S"
    grammar.variables << "D"
    grammar.variables << "D'"
    grammar.variables << "D''"
    grammar.variables << "I"
    grammar.variables << "I'"
    grammar.variables << "I''"
    grammar.variables << "E"
    grammar.variables << "E'"
    grammar.variables << "E''"
    grammar.variables << "M"
    grammar.variables << "M'"
    grammar.variables << "P"
    grammar.variables << "C"
    grammar.variables << "C'"
    grammar.variables << "C''"
    grammar.variables << "C'''"
    grammar.variables << "F"
    grammar.variables << "F'"
    grammar.variables << "W"
    grammar.variables << "R"
    grammar.variables << "Q"
    grammar.variables << "Q'"

    grammar.terminals << 'DEC_OP'
    grammar.terminals << 'INC_OP'
    grammar.terminals << '+'
    grammar.terminals << '('
    grammar.terminals << ')'
    grammar.terminals << '*'
    grammar.terminals << '{'
    grammar.terminals << '}'
    grammar.terminals << ';'
    grammar.terminals << 'LE_OP'
    grammar.terminals << '<'
    grammar.terminals << 'GE_OP'
    grammar.terminals << '>'
    grammar.terminals << '='
    grammar.terminals << 'EQ_OP'
    grammar.terminals << 'NE_OP'
    grammar.terminals << 'IF'
    grammar.terminals << 'ELSE'
    grammar.terminals << 'WHILE'
    grammar.terminals << '['
    grammar.terminals << ']'
    
    grammar.terminals << 'TYPE'
    grammar.terminals << 'ID'
    grammar.terminals << 'INTEGER'
    grammar.terminals << 'DOUBLE'
    grammar.terminals << 'CHARACTER'
    grammar.terminals << 'PRINTF'
    grammar.terminals << 'STRING'

    grammar.rules << ProductionRule.new("Z",['TYPE','ID','(',')',"B"])
    grammar.rules << ProductionRule.new("B",['{','S','}'])
    grammar.rules << ProductionRule.new("S",["D","S"])
    grammar.rules << ProductionRule.new("S",["I","S"])
    grammar.rules << ProductionRule.new("S",["F","S"])
    grammar.rules << ProductionRule.new("S",["W","S"])
    grammar.rules << ProductionRule.new("S",["R","S"])
    grammar.rules << ProductionRule.new("S",["Q","S"])
    grammar.rules << ProductionRule.new("S",["@"])

    grammar.rules << ProductionRule.new("D",["TYPE","D'"])
    grammar.rules << ProductionRule.new("D'",["ID","D''"])
    grammar.rules << ProductionRule.new("D''",["[","INTEGER","]",";"])
    grammar.rules << ProductionRule.new("D''",[";"])
    grammar.rules << ProductionRule.new("D''",["=","I''"])
    
    # grammar.rules << ProductionRule.new("I",["I'",";"])
    grammar.rules << ProductionRule.new("I",["ID", "=" ,"I''"])
    # grammar.rules << ProductionRule.new("I''",["ID"])
    grammar.rules << ProductionRule.new("I''",["CHARACTER" , ";"])
    # grammar.rules << ProductionRule.new("I''",["INTEGER"])
    # grammar.rules << ProductionRule.new("I''",["DOUBLE"])
    grammar.rules << ProductionRule.new("I''",["E"])
    
    grammar.rules << ProductionRule.new("R",["INC_OP","ID",";"])
    grammar.rules << ProductionRule.new("R",["DEC_OP","ID",";"])
    
    grammar.rules << ProductionRule.new("E",["E''",";"])
    grammar.rules << ProductionRule.new("E''",["M","E'"])
    grammar.rules << ProductionRule.new("E'",['+','M',"E'"])
    grammar.rules << ProductionRule.new("E'",['@'])
    grammar.rules << ProductionRule.new("M",['P',"M'"])
    grammar.rules << ProductionRule.new("M'",['*',"P","M'"])
    grammar.rules << ProductionRule.new("M'",['@'])
    grammar.rules << ProductionRule.new("P",['(',"E''",")"])
    grammar.rules << ProductionRule.new("P",['ID'])
    grammar.rules << ProductionRule.new("P",['INTEGER'])
    grammar.rules << ProductionRule.new("P",['DOUBLE'])

    grammar.rules << ProductionRule.new("C",["(","C'",")"])
    grammar.rules << ProductionRule.new("C'",["C'''","C''","C'''"])
    
    grammar.rules << ProductionRule.new("C''",[">"])
    grammar.rules << ProductionRule.new("C''",["<"])
    grammar.rules << ProductionRule.new("C''",["GE_OP"])
    grammar.rules << ProductionRule.new("C''",["LE_OP"])
    grammar.rules << ProductionRule.new("C''",["EQ_OP"])
    grammar.rules << ProductionRule.new("C''",["NE_OP"])
    grammar.rules << ProductionRule.new("C'''",["ID"])
    grammar.rules << ProductionRule.new("C'''",["INTEGER"])
    grammar.rules << ProductionRule.new("C'''",["DOUBLE"])
    grammar.rules << ProductionRule.new("C'''",["CHARACTER"])
    
    grammar.rules << ProductionRule.new("F",["IF","C","B", "F'"])
    grammar.rules << ProductionRule.new("F'",["ELSE" , "B"])
    grammar.rules << ProductionRule.new("F'",["@"])
   
    grammar.rules << ProductionRule.new("W",["WHILE","C","B"])
    grammar.rules << ProductionRule.new("Q",["PRINTF","(","Q'",")",";"])
    grammar.rules << ProductionRule.new("Q'",["ID"])
    grammar.rules << ProductionRule.new("Q'",["CHARACTER"])
    grammar.rules << ProductionRule.new("Q'",["DOUBLE"])
    grammar.rules << ProductionRule.new("Q'",["INTEGER"])
    grammar.rules << ProductionRule.new("Q'",["STRING"])

    grammar.initial_symbol = "Z"
    grammar.delimiter_symbol = "DELIMITER"

    grammar
  end
  
end