# frozen_string_literal: true

# Tests on the freetext feature
RSpec.describe 'operators' do
  it 'only one as string' do
    query = 'operator: value'
    search = Searrrch.new query
    search.each_value(:operator) do |value|
      expect(value).to eq 'value'
    end
  end

  it 'only one as integer' do
    query = 'operator: 123'
    search = Searrrch.new query
    search.each_value(:operator, :integer) do |value|
      expect(value).to eq 123
    end
  end

  it 'has text with # ' do
    query = 'hashtag: #hashtag,#hashtag2'
    search = Searrrch.new query, true
    expect(search.to_array(:hashtag)).to eq %w(#hashtag #hashtag2)
  end

  it 'only one as \"rails model\"' do
    module FakeModel
      def self.find(id)
        "it worked for #{id}"
      end
    end
    query = 'operator: 123'
    search = Searrrch.new query
    search.each_value(:operator, FakeModel) do |value|
      expect(value).to eq 'it worked for 123'
    end
  end

  it 'has one operator with \'' do
    query = 'operator: \'123 is lol\''
    search = Searrrch.new query
    search.each_value(:operator) do |value|
      expect(value).to eq '123 is lol'
    end
  end

  it 'has one operator with "' do
    query = 'operator: "123 is lol"'
    search = Searrrch.new query
    search.each_value(:operator) do |value|
      expect(value).to eq '123 is lol'
    end
  end

  it 'has multiple operators with "' do
    query = 'operator: "123 is lol" otheroperator: "12" operator: "other value"'
    expectedvalue = '123 is lol'
    othervalue = 'other value'
    search = Searrrch.new query
    search.each_value(:operator) do |value|
      expect(value).to eq expectedvalue
      expectedvalue = othervalue
    end
  end

  it 'has multiple operators with \'' do
    query = 'operator: \'123 is lol\' otheroperator: \'12\' operator: \'other value\''
    expectedvalue = '123 is lol'
    othervalue = 'other value'
    search = Searrrch.new query
    search.each_value(:operator) do |value|
      expect(value).to eq expectedvalue
      expectedvalue = othervalue
    end
  end

  it 'has multiple operators with \' and "' do
    query = 'operator: \'123 is " lol\' otheroperator: \'12\' operator: "other \' value"'
    expectedvalue = '123 is " lol'
    othervalue = 'other \' value'
    search = Searrrch.new query
    search.each_value(:operator) do |value|
      expect(value).to eq expectedvalue
      expectedvalue = othervalue
    end
  end

  it 'has multiple operators with \' and " return as array' do
    query = 'operator: \'123 is " lol\' otheroperator: \'12\' operator: "other \' value"'
    values = ['123 is " lol', 'other \' value']
    search = Searrrch.new query
    expect(search.to_array(:operator)).to eq values
  end

  it 'explodes the comma' do
    query = 'user_id: 1,2,3,4'
    search = Searrrch.new query, true
    expect(search.to_array(:user_id, :integer)).to eq [1,2,3,4]
  end

  it 'uses as_array instead of to_array' do
    query = 'user_id: 1,2,3,4'
    search = Searrrch.new query, true
    called = false
    search.as_array(:user_id, :integer) do |value|
      expect(value).to eq [1,2,3,4]
      called = true
    end
    expect(called).to eq(true)
    expect { |b| search.as_array(:unset_value, :integer, &b) }.not_to yield_control
  end

  it 'uses a translation hash' do
    query = 'status: new,closed'
    search = Searrrch.new query, true
    translation = { new: 1, 'closed' => 2 }
    expect(search.to_array(:status, translation)).to eq([1,2])
  end
end
