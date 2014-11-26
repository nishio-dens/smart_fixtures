class SmartFixtures::VariableSet
  attr_reader :variable_set

  def initialize
    @variable_set = {}
  end

  def let(variable_name, &block)
    value = block.call
    @variable_set[variable_name] = value
    self.instance_variable_set("@#{variable_name}", value)
    self.class.send(:attr_reader, variable_name)
  end
end
