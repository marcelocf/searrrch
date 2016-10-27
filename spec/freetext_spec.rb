# frozen_string_literal: true

# Tests on the freetext feature
RSpec.describe 'freetext' do
  it 'only free text' do
    query = 'I only contain free text'
    search = Searrrch.new query
    expect(search.freetext).to eq query
  end

  it 'after one option' do
    freetext = 'this is an example freetext'
    query = "option1: value #{freetext}"
    search = Searrrch.new query
    expect(search.freetext).to eq freetext
  end

  it 'after one option ending with "' do
    freetext = 'this is an example freetext'
    query = "option1: \"a bigger value\" #{freetext}"
    search = Searrrch.new query
    expect(search.freetext).to eq freetext
  end

  it 'after one option ending with \'' do
    freetext = 'this is an example freetext'
    query = "option1: \'a bigger value\' #{freetext}"
    search = Searrrch.new query
    expect(search.freetext).to eq freetext
  end

  it 'with lots of ending and beginning spaces' do
    freetext = 'this is an example freetext'
    query = "option1: \'a bigger value\'      #{freetext}     "
    search = Searrrch.new query
    expect(search.freetext).to eq freetext
  end

  it 'containing : but not as an operator' do
    freetext = 'this is an example with : freetext'
    query = "option1: \'a bigger value\' #{freetext}"
    search = Searrrch.new query
    expect(search.freetext).to eq freetext
  end
end
