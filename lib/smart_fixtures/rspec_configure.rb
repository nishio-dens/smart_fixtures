if defined?(RSpec)
  RSpec.configure do |c|
    c.extend SmartFixtures

    c.before(:each) do
      DatabaseRollbacker::Rollbacker.instance.save(:before_each_smart_fixture)
    end
    c.after(:each) do
      DatabaseRollbacker::Rollbacker.instance.rollback(:before_each_smart_fixture)
    end
  end
end
