class Automata

  attr_accessor :table # hash with all transitions
  attr_accessor :initial_state # initial state of automata
  attr_accessor :final_states # all final states of automata
  attr_accessor :alphabet # alphabet of altomata
  attr_accessor :states # all states of altomata
  
  def initialize
    @table = {}
    @final_states = Set.new
    @alphabet = Set.new
    @states = Set.new
  end

  def add_in_alphabet(*sub_alphabet)
    sub_alphabet.each do |char|
      self.alphabet << char
    end
  end

  def add_states(*states_to_add)
    states_to_add.each do |state|
      self.states << state
    end
  end

  def add_initial_state(state)
    self.initial_state = state
  end

  def add_final_states(*states_to_add)
    states_to_add.each do |state|
      self.final_states << state
    end
  end

  def add_transition(transition_to,state)
    if self.table[transition_to].nil?
      self.table[transition_to] = Set.new.add(state)
    else
      self.table[transition_to].add(state)
    end 
  end
  
  def remove_states(*states_to_remove)
    states_to_remove.each do |state|
      self.states.delete(state)
    end
  end
  
  def remove_transition(transition)
    self.table.delete(transition)
  end
  
  def add_states_from_array(states_array)
    states_array.each do |state|
      add_states(state)
    end
  end
  
  def add_alphabet_from_array(alphabet_array)
    alphabet_array.each do |char|
      add_in_alphabet(char)
    end
  end
  
  def add_final_states_from_array(final_states_array)
    final_states_array.each do |state|
      add_final_states(state)
    end
  end
  
  def initial_is_final?
    self.final_states.include?(self.initial_state)
  end
  
  def has_just_one_state?
    self.states.size == 1 ? true : false
  end
  
end