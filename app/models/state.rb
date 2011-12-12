class State

  attr_accessor :state
  @@state_number = 0
  
  def initialize
    @state = "q#{get_state_number_and_increment}"
  end

  def to_s
    state
  end

  def ==(other_state)
    begin
      state == other_state.state
    rescue
      false
    end
  end
  
  def +(obj)
    self.state + obj.to_s 
  end

private

  def get_state_number_and_increment
    state = @@state_number
    increment_state_number
    state
  end

  def increment_state_number
    @@state_number += 1
  end

end