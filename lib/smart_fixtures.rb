require "smart_fixtures/version"
require 'database_rollbacker'
require 'smart_fixtures/rspec_configure'
require 'smart_fixtures/variable_set'

module SmartFixtures
  class << self
    attr_accessor :fixture_set, :fixture_variable_set

    def define_dataset(fixture_name, &block)
      @fixture_set ||= {}
      @fixture_variable_set ||= {}
      @fixture_set[fixture_name] = block
      @fixture_variable_set[fixture_name] = SmartFixtures::VariableSet.new
    end

    def data(fixture_name, variable_name)
      fixture_set = @fixture_variable_set[fixture_name]
      return nil if fixture_set.nil?
      fixture_set.variable_set[variable_name]
    end
  end

  def smart_fixtures(*args)
    before(:all) do
      DatabaseRollbacker::Rollbacker.instance.save(:before_load_smart_fixture)
      args.each do |fixture_name|
        if SmartFixtures.fixture_variable_set.nil? ||
          SmartFixtures.fixture_variable_set[fixture_name].nil?
          raise ArgumentError.new("Fixture #{fixture_name} not found")
        end
        SmartFixtures
          .fixture_variable_set[fixture_name]
          .instance_eval(&SmartFixtures.fixture_set[fixture_name])
      end
    end
    after(:all) do
      DatabaseRollbacker::Rollbacker.instance.rollback(:before_load_smart_fixture)
    end
  end
end
