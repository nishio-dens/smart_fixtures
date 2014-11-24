class SmartFixtures::VariableSet
  attr_reader :variable_set

  def initialize
    @variable_set = {}
  end

  def let(variable_name, &block)
    @variable_set[variable_name] = block.call
  end
end
