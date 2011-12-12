class TRegex

  attr_accessor :regular_expression
  attr_accessor :nf_automata
  
  def initialize(regular_expression)
    regular_expression.gsub!("#","a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z|A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z")
    regular_expression.gsub!("@","0|1|2|3|4|5|6|7|8|9")
    @regular_expression = regular_expression
    @nf_automata = reg_exp_to_automata
  end

  def match?(word)
    return true if nf_automata.initial_is_final? && word.empty?
    return false if !nf_automata.initial_is_final? && word.empty?
    verify_automata(nf_automata.initial_state,word,0)
  end

  def verify_automata(state,word,indice)
    return false if next_states(state,word[indice]).nil?

    if indice == word.length-1
      next_states(state,word[indice]).each do |st|
        return true if nf_automata.final_states.include?(st)
      end
    return false
    end

    result = false
    next_states(state,word[indice]).each do |st|
      result ||= verify_automata(st,word,indice+1)
    end
    result
  end

  def to_s
    regular_expression
  end

  def length
    regular_expression.length
  end

private

  def next_states(state,char)
    nf_automata.table[state+char]
  end

  def reg_exp_to_automata
    @reg_exp_postfix = reg_exp_to_postfix
    puts @reg_exp_postfix
    postfix_to_automata
  end

  def reg_exp_to_postfix
    @parentheses = 0
    @reg_index = 0
    reg_exp_to_postfix_helper
  end

  def reg_exp_to_postfix_helper
    reg_exp_post = ""
    number_outs = 0
    number_atoms = 0

    while @reg_index < length do
      char = regular_expression[@reg_index]

      case char

      when '('
        if number_atoms > 1
          number_atoms -= 1
          reg_exp_post << '^'
        end

        @reg_index += 1
        @parentheses += 1

        sub_reg_exp_post = reg_exp_to_postfix_helper

        return nil if sub_reg_exp_post.nil?

        reg_exp_post << sub_reg_exp_post
        number_atoms += 1

      when '|'
        return nil if number_atoms == 0

        number_atoms -= 1
        while number_atoms > 0 do
          reg_exp_post << '^'
          number_atoms -= 1
        end

        number_outs += 1

      when ')'
        return nil if @parentheses <= 0 || number_atoms == 0

        number_atoms -= 1
        while number_atoms > 0 do
          reg_exp_post << '^'
          number_atoms -= 1
        end

        while number_outs > 0 do
          reg_exp_post << '|'
          number_outs -= 1
        end
        return reg_exp_post

      when '*' , '+'  
        return nil if number_atoms == 0
        reg_exp_post << char

      else
        if number_atoms > 1
          number_atoms -= 1
          reg_exp_post << '^'
        end

        reg_exp_post << char
        number_atoms += 1
      end

      @reg_index += 1
    end

    number_atoms -= 1
    while number_atoms > 0 do
      reg_exp_post << '^'
      number_atoms -= 1
    end

    while number_outs > 0 do
      reg_exp_post << '|'
      number_outs -= 1
    end

    reg_exp_post
  end

  def postfix_to_automata
    stack = []

    @reg_exp_postfix.each_char do |char|

      case char
      when '^'
        do_catenate(stack)
      when '|'
        do_alternate(stack)
      when '*'
        do_zero_or_more(stack)
      when '+'
        do_one_or_more(stack)
      else
      do_simple_char(stack,char)
      end
    end

    return nil if stack.size > 1
    return stack.pop
  end

  def do_catenate(stack)
    a2 = stack.pop
    a1 = stack.pop
    a3 = a1 & a2
    stack.push a3
  end

  def do_alternate(stack)
    a2 = stack.pop
    a1 = stack.pop
    a3 = a1 | a2
    stack.push a3
  end

  def do_zero_or_more(stack)
    a1 = stack.pop
    a2 = a1.zero_or_more
    stack.push a2
  end

  def do_one_or_more(stack)
    a1 = stack.pop
    a2 = a1.one_or_more
    stack.push a2
  end

  def do_simple_char(stack,char)
    a1 = NfAutomata.simple_nf_automata(char)
    stack.push a1
  end

end
