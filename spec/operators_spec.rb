require 'search_operators'
require 'pp'
# Tests on the freetext feature
RSpec.describe 'operators' do
  it 'only one as string' do
    query = 'operator: value'
    search = SearchOperators.new query
    search.operator(:operator) do |value|
      expect(value).to eq 'value'
    end
  end

  it 'only one as integer' do
    query = 'operator: 123'
    search = SearchOperators.new query
    search.operator(:operator, :integer) do |value|
      expect(value).to eq 123
    end
  end

  it 'only one as \"rails model\"' do
    module FakeModel
      def self.find(id)
        "it worked for #{id}"
      end
    end
    query = 'operator: 123'
    search = SearchOperators.new query
    search.operator(:operator, FakeModel) do |value|
      expect(value).to eq 'it worked for 123'
    end
  end

  it 'has one operator with \'' do
    query = 'operator: \'123 is lol\''
    search = SearchOperators.new query
    search.operator(:operator) do |value|
      expect(value).to eq '123 is lol'
    end
  end

  it 'has one operator with "' do
    query = 'operator: "123 is lol"'
    search = SearchOperators.new query
    search.operator(:operator) do |value|
      expect(value).to eq '123 is lol'
    end
  end

  it 'has multiple operators with "' do
    query = 'operator: "123 is lol" otheroperator: "12" operator: "other value"'
    expectedvalue = "123 is lol"
    othervalue = "other value"
    search = SearchOperators.new query
    search.operator(:operator) do |value|
      expect(value).to eq expectedvalue
      expectedvalue = othervalue
    end
  end

  it 'has multiple operators with \'' do
    query = 'operator: \'123 is lol\' otheroperator: \'12\' operator: \'other value\''
    expectedvalue = "123 is lol"
    othervalue = "other value"
    search = SearchOperators.new query
    search.operator(:operator) do |value|
      expect(value).to eq expectedvalue
      expectedvalue = othervalue
    end
  end


  it 'has multiple operators with \' and "' do
    query = 'operator: \'123 is " lol\' otheroperator: \'12\' operator: "other \' value"'
    expectedvalue = '123 is " lol'
    othervalue = 'other \' value'
    search = SearchOperators.new query
    search.operator(:operator) do |value|
      expect(value).to eq expectedvalue
      expectedvalue = othervalue
    end
  end


  it 'has multiple operators with \' and " return as array' do
    query = 'operator: \'123 is " lol\' otheroperator: \'12\' operator: "other \' value"'
    values = ['123 is " lol', 'other \' value']
    search = SearchOperators.new query
    search.as_array(:operator) do |value|
      expect(value).to eq expectedvalues
    end
  end
end
