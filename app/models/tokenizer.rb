#encoding: UTF-8
class Tokenizer

  attr_accessor :tokens
  attr_accessor :comments
  
  def initialize(file_name)
    @lexeme = ""
    @tokens = []
    @line_number = 1
    @simple_comment = false
    @block_comment = false
    @string = false
    tokenize(file_name)
  end

  def tokenize(file_name)
    path = File.join(Rails.root,"public/files",file_name)
    File.open(path,"r") do |f|
      f.readlines.each do |line|
        @line = line.chop
        make_token
        @line_number += 1
      end
    end
    classify_token(@lexeme,@line_number) unless @lexeme.empty?
  end

  def make_token
    @index = 0
    while @index < @line.length
      if @simple_comment
        do_simple_comment(@line[@index])
      else 
        if @block_comment
          do_block_comment(@line[@index])
        else
          if @string
            do_string(@line[@index])
          else
            verify_char(@line[@index])
          end   
        end
      end
      @index += 1
    end
  end

  def verify_char(char)
    case char
    when " ","\t"
      classify_token(@lexeme,@line_number) unless @lexeme.empty?
      @lexeme = ""
    when "("
      classify_token(@lexeme,@line_number) unless @lexeme.empty?
      classify_token("(",@line_number)
      @lexeme = ""
    when ")"
      classify_token(@lexeme,@line_number) unless @lexeme.empty?
      classify_token(")",@line_number)
      @lexeme = ""
    when "{"
      classify_token(@lexeme,@line_number) unless @lexeme.empty?
      classify_token("{",@line_number)
      @lexeme = ""
    when "}"
      classify_token(@lexeme,@line_number) unless @lexeme.empty?
      classify_token("}",@line_number)
      @lexeme = ""
    when "["
      classify_token(@lexeme,@line_number) unless @lexeme.empty?
      classify_token("[",@line_number)
      @lexeme = ""
    when "]"
      classify_token(@lexeme,@line_number) unless @lexeme.empty?
      classify_token("]",@line_number)
      @lexeme = ""
    when "*"
      classify_token(@lexeme,@line_number) unless @lexeme.empty?
      classify_token("*",@line_number)
      @lexeme = ""
    when ";"
      classify_token(@lexeme,@line_number) unless @lexeme.empty?
      classify_token(";",@line_number)
      @lexeme = ""
    when ","
      classify_token(@lexeme,@line_number) unless @lexeme.empty?
      classify_token(",",@line_number)
      @lexeme = ""
    when "+"
      do_plus
    when "-"
      do_minus
    when "/"
      do_bar
    when "&"
      do_and
    when "|"
      do_or
    when "!"
      do_not
    when "<"
      do_let
    when ">"
      do_gre
    when "="
      do_eql
    when "'"
      do_char
    when "\""
      classify_token(@lexeme,@line_number) unless @lexeme.empty?
      @lexeme = "\""
      @string = true
    else
      @lexeme << char
    end
  end

  def classify_token(lexeme,line)
    return tokens << Token.new(lexeme,SymbolTable::RESERVED_WORDS[lexeme],line) unless SymbolTable::RESERVED_WORDS[lexeme].nil?
    return tokens << Token.new(lexeme,SymbolTable::OPERATORS[lexeme],line) unless SymbolTable::OPERATORS[lexeme].nil?
    return tokens << Token.new(lexeme,SymbolTable::EMPTY_SPACE,line) if SymbolTable.empty_space?(lexeme)
    return tokens << Token.new(lexeme,SymbolTable::INTEGER,line) if SymbolTable.integer?(lexeme)
    return tokens << Token.new(lexeme,SymbolTable::DOUBLE,line) if SymbolTable.double?(lexeme)
    return tokens << Token.new(lexeme,SymbolTable::CHARACTER,line) if SymbolTable.char?(lexeme)
    return tokens << Token.new(lexeme,SymbolTable::STRING,line) if SymbolTable.string?(lexeme)
    return tokens << Token.new(lexeme,SymbolTable::IDENTIFY,line) if SymbolTable.identify?(lexeme)
    return comments << Token.new(lexeme,SymbolTable::COMMENT,line) if SymbolTable.simple_comment?(lexeme)
    return comments << Token.new(lexeme,SymbolTable::COMMENT,line) if SymbolTable.block_comment?(lexeme)
    return tokens << Token.new(lexeme,SymbolTable::ERROR,line)
  end

private

  def do_plus
    classify_token(@lexeme,@line_number) unless @lexeme.empty?
    if @line[@index + 1] == "+"
      classify_token("++",@line_number)
      @index += 1
    else
      classify_token("+",@line_number)
    end
    @lexeme = ""
  end

  def do_minus
    classify_token(@lexeme,@line_number) unless @lexeme.empty?
    if @line[@index + 1] == "-"
      classify_token("--",@line_number)
      @index += 1
    else
      classify_token("-",@line_number)
    end
    @lexeme = ""
  end

  def do_eql
    classify_token(@lexeme,@line_number) unless @lexeme.empty?
    if @line[@index + 1] == "="
      classify_token("==",@line_number)
      @index += 1
    else
      classify_token("=",@line_number)
    end
    @lexeme = ""
  end

  def do_and
    classify_token(@lexeme,@line_number) unless @lexeme.empty?
    if @line[@index + 1] == "&"
      classify_token("&&",@line_number)
      @index += 1
    else
      classify_token("&",@line_number)
    end
    @lexeme = ""
  end

  def do_or
    classify_token(@lexeme,@line_number) unless @lexeme.empty?
    if @line[@index + 1] == "|"
      classify_token("||",@line_number)
      @index += 1
    else
      classify_token("|",@line_number)
    end
    @lexeme = ""
  end

  def do_not
    classify_token(@lexeme,@line_number) unless @lexeme.empty?
    if @line[@index + 1] == "="
      classify_token("!=",@line_number)
      @index += 1
    else
      classify_token("!",@line_number)
    end
    @lexeme = ""
  end

  def do_let
    classify_token(@lexeme,@line_number) unless @lexeme.empty?
    if @line[@index + 1] == "="
      classify_token("<=",@line_number)
      @index += 1
    else
      classify_token("<",@line_number)
    end
    @lexeme = ""
  end

  def do_gre
    classify_token(@lexeme,@line_number) unless @lexeme.empty?
    if @line[@index + 1] == "="
      classify_token(">=",@line_number)
      @index += 1
    else
      classify_token(">",@line_number)
    end
    @lexeme = ""
  end
  
  def do_char
    classify_token(@lexeme,@line_number) unless @lexeme.empty?
    if @line[@index + 2] == "'"
      classify_token("'#{@line[@index+1]}'",@line_number)
      @index += 2
    else 
      if @line[@index + 1] == "'"
        classify_token("''",@line_number)
        @index += 1
      else
        classify_token("'#{@line[@index+1]}",@line_number)
        @index += 1
      end
    end
    @lexeme = ""
  end
  
  def do_string(char)
    @lexeme += char
    if char == "\""
      classify_token(@lexeme,@line_number)
      @string = false
      @lexeme = ""
    else 
      if @index == (@line.length - 1)
        classify_token(@lexeme,@line_number)
        @string = false
        @lexeme = ""
      end
    end
  end
  
  def do_bar
    classify_token(@lexeme,@line_number) unless @lexeme.empty?
    @lexeme = ""
    case @line[@index + 1]
    when '/'
      @simple_comment = true
      @index += 1
      @lexeme = "//"
    when '*'
      @block_comment = true
      @index += 1
      @lexeme = "/*"
    else
      classify_token("/",@line_number)
    end
  end

  def do_simple_comment(char)
    @lexeme += char
    if @index == (@line.length - 1) #ultimo caractere
      @simple_comment = false
      @lexeme = ""
    end      
  end
  
  def do_block_comment(char)
    @lexeme += char
    if "#{@line[@index-1]}#{char}" == "*/"  
      @block_comment = false
      @lexeme = ""
    end      
  end
  
end
