require 'spec_helper'

SmartFixtures.define_dataset :smart_fixture_testdata do
  let(:variable_test) { 'TESTVALUE' }
  let(:concat_variable_test) { variable_test + 'TEST' }

  fixture_local_variable = 'LOCAL VALUE'
  let(:local_variable_test) { fixture_local_variable }
end

describe SmartFixtures do
  smart_fixtures :smart_fixture_testdata, use_fixture_variables: true

  it 'should be useable fixture value' do
    expect(variable_test).to eq 'TESTVALUE'
    expect(concat_variable_test).to eq 'TESTVALUETEST'
  end

  it 'should be useable fixture local value' do
    expect(local_variable_test).to eq 'LOCAL VALUE'
  end
end
