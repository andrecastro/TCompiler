class NfAutomata < Automata
 
  def self.simple_nf_automata(char)
    result_automata = NfAutomata.new
    initial_state = State.new
    final_state = State.new
    transition_to = initial_state + char

    result_automata.add_initial_state(initial_state)
    result_automata.add_final_states(final_state)
    result_automata.add_transition(transition_to , final_state)
    result_automata.add_states(initial_state,final_state)
    result_automata.add_in_alphabet(char)

    result_automata
  end

  def &(automata)
    result_automata = NfAutomata.new
    result_automata.add_initial_state(self.initial_state)
    result_automata.add_final_states_from_array(automata.final_states)
    result_automata.add_states_from_array(self.states + automata.states)
    result_automata.add_alphabet_from_array(self.alphabet + automata.alphabet)
    result_automata.table.merge! self.table.merge(automata.table)

    result_automata.remove_states(automata.initial_state) unless automata.initial_is_final?
    result_automata.add_final_states_from_array(self.final_states) if automata.initial_is_final?

    NfAutomata.link_automata_one_to_automata_two(result_automata,self,automata)
    NfAutomata.remove_initial_transitions_of_automata_two(result_automata,automata) unless automata.initial_is_final?

    result_automata
  end

  def |(automata)
    result_automata = NfAutomata.new
    new_state = State.new

    result_automata.add_initial_state(new_state)
    result_automata.add_states(new_state)
    result_automata.add_final_states_from_array(self.final_states + automata.final_states)
    result_automata.add_states_from_array(self.states + automata.states)
    result_automata.add_alphabet_from_array(self.alphabet + automata.alphabet)
    result_automata.table.merge! self.table.merge(automata.table)

    NfAutomata.link_new_state_to_automata(result_automata,new_state,self)

    if self.zero_or_more?
      result_automata.add_final_states(result_automata.initial_state)
    else
      result_automata.remove_states(self.initial_state)
      result_automata.final_states.delete(self.initial_state)
      NfAutomata.remove_initial_transitions_of_automata_two(result_automata,self)
    end

    NfAutomata.link_new_state_to_automata(result_automata,new_state,automata)

    if automata.zero_or_more?
      result_automata.add_final_states(result_automata.initial_state)
    else
      result_automata.remove_states(automata.initial_state)
      result_automata.final_states.delete(automata.initial_state)
      NfAutomata.remove_initial_transitions_of_automata_two(result_automata,automata)
    end

    result_automata
  end

  def zero_or_more
    result_automata = NfAutomata.new
    result_automata.add_initial_state(self.initial_state)
    result_automata.add_final_states(self.initial_state)
    result_automata.add_states_from_array(self.states)
    result_automata.add_alphabet_from_array(self.alphabet)
    result_automata.table.merge! self.table

    self.transitions_to_final_states.each do |transition|
      result_automata.table[transition] = Set[result_automata.initial_state]
    end

    self.final_states.each do |state|
      result_automata.remove_states(state)
    end

    # if self.initial_is_final?
      # result_automata.add_states(self.initial_state)
      # result_automata.add_final_states(self.initial_state)
    # end

    result_automata
  end

  def one_or_more
    result_automata = NfAutomata.new
    result_automata.add_initial_state(self.initial_state)
    result_automata.add_states_from_array(self.states)
    result_automata.add_alphabet_from_array(self.alphabet)
    result_automata.add_final_states_from_array(self.final_states)
    result_automata.table.merge! self.table

    result_automata.final_states.each do |final_state|
      self.alphabet_to_second_states.each do |char|
        final_to = final_state + char
        self.table[self.initial_state + char].each do |second_state|
          result_automata.add_transition(final_to,second_state)
        end
      end
    end

    result_automata
  end

  def alphabet_to_second_states
    sub_alphabet = Set.new
    self.alphabet.each do |char|
      transition = self.initial_state + char
      sub_alphabet.add(char) unless self.table[transition].nil?
    end
    sub_alphabet
  end

  def alphabet_to_initial_states
    sub_alphabet = Set.new
    self.alphabet.each do |char|
      self.states.each do |state|
        transition = state + char
        sub_alphabet.add(char) if self.table[transition].nil? && self.table[transition].include?(self.initial_state)
      end
    end
    sub_alphabet
  end

  def transitions_to_final_states
    transitions = Set.new
    self.table.keys.each do |transition|
      self.final_states.each do |state|
        transitions.add(transition) if self.table[transition].include?(state)
      end
    end
    transitions
  end

  def transitions_to_initial_state
    transitions = Set.new
    self.table.keys.each do |transition|
      transitions.add(transition) if self.table[transition].include?(self.initial_state)
    end
    transitions
  end

  def transitions_to_second_states
    transitions = Set.new
    self.alphabet.each do |char|
      transition = self.initial_state + char
      transitions.add(transition) unless self.table[transition].nil?
    end
    transitions
  end

  def zero_or_more?
    self.initial_is_final? && (self.transitions_to_initial_state.size > 0)
  end


private

  def self.link_automata_one_to_automata_two(result_automata,automata1,automata2)
    automata1.final_states.each do |state|
      automata2.alphabet_to_second_states.each do |char|
        transition = state+char
        automata2.table[automata2.initial_state+char].each do |second_state|
          result_automata.add_transition(transition, second_state)
        end
      end
    end
    result_automata
  end

  def self.remove_initial_transitions_of_automata_two(result_automata,automata)
    automata.alphabet_to_second_states.each do |char|
      result_automata.remove_transition(automata.initial_state+char)
    end
    result_automata
  end

  def self.link_new_state_to_automata(result_automata,new_state,automata)
    automata.alphabet_to_second_states.each do |char|
      new_state_to = new_state + char
      automata.table[automata.initial_state+char].each do |second_state|
        result_automata.add_transition(new_state_to,second_state)
      end
    end
  end

end
