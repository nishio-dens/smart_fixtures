require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'smart_fixtures'
Dir["#{File.dirname(__FILE__)}/integrations/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
end

module DatabaseRollbacker
  class Rollbacker
    def instance; self end
    def save(args); true end
    def rollback(args); true end
  end
end
