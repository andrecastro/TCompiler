#encoding: UTF-8
class SymbolTable
  
  RESERVED_WORDS = { 
    "char" => "CHAR",
    "int" => "INT",
    "double" => "DOUB",
    "else" => "ELSE",
    "if" => "IF",
    "while" => "WHILE",
    "for" => "FOR",
    "printf" => "PRINTF"
  }
  
  ERROR = "ERROR"
  
  EMPTY_SPACE = "EMPTY"

  OPERATORS = {
    "++" => "INC_OP",
    "--" => "DEC_OP",
    "&&" => "AND_OP",
    "||" => "OR_OP",
    "!=" => "NE_OP",
    "<=" => "LE_OP",
    ">=" => "GE_OP",
    "==" => "EQ_OP",
    ">" => ">",
    "<" => "<",
    ";" => ";",
    "," => ",",
    "=" => "=",
    "(" => "(",
    ")" => ")",
    "!" => "!",
    "-" => "-",
    "+" => "+",
    "*" => "*",
    "/" => "/",
    "{" => "{",
    "}" => "}",
    "[" => "[",
    "]" => "]"
  }
  
  IDENTIFY = "ID"
  
  STRING = "STRING"
  
  INTEGER = "INTEGER"
  
  CHARACTER = "CHARACTER"
  
  DOUBLE = "DOUBLE"
  
  COMMENT = "COMMENT"
  
  def self.empty_space?(lexeme)
    return lexeme == " "
  end
  
  def self.identify?(lexeme)
    ID_REGEX.match?(lexeme)   
  end
 
  def self.integer?(lexeme)
    INT_REGEX.match?(lexeme)
  end
  
  def self.double?(lexeme)
    DOUBLE_REGEX.match?(lexeme)
  end
  
  def self.char?(lexeme)
    return lexeme.start_with?("'") && lexeme.end_with?("'")
  end
  
  def self.simple_comment?(lexeme)
    return lexeme.start_with?("//")
  end
  
  def self.block_comment?(lexeme)
    return lexeme.start_with?("/*") && lexeme.end_with?("*/")
  end
  
  def self.string?(lexeme)
    return lexeme.start_with?("\"") && lexeme.end_with?("\"")
  end
  
  
  
private

  ID_REGEX = TRegex.new("(#)(#|@)*")  
  INT_REGEX = TRegex.new("(@)+")
  DOUBLE_REGEX = TRegex.new("(@)+.(@)+")
  
  
  
end
