require 'search_operators'
# Tests on the freetext feature
RSpec.describe 'freetext' do
  it 'only free text' do
    query = 'I only contain free text'
    search = SearchOperators.new query
    search.freetext do |freetext|
      expect(freetext).to eq query
    end
  end

  it 'after one option' do
    freetext = 'this is an example freetext'
    query = "option1: value #{freetext}"
    search = SearchOperators.new query
    search.freetext do |freetext|
      expect(freetext).to eq freetext
    end
  end


  it 'after one option ending with "' do
    freetext = "this is an example freetext"
    query = "option1: \"a bigger value\" #{freetext}"
    search = SearchOperators.new query
    search.freetext do |freetext|
      expect(freetext).to eq freetext
    end
  end


  it 'after one option ending with \'' do
    freetext = "this is an example freetext"
    query = "option1: \'a bigger value\' #{freetext}"
    search = SearchOperators.new query
    search.freetext do |freetext|
      expect(freetext).to eq freetext
    end
  end


  it 'with lots of ending and beginning spaces' do
    freetext = "this is an example freetext"
    query = "option1: \'a bigger value\'      #{freetext}     "
    search = SearchOperators.new query
    search.freetext do |freetext|
      expect(freetext).to eq freetext
    end
  end


  it 'containing : but not an operator' do
    freetext = "this is an example with : freetext"
    query = "option1: \'a bigger value\' #{freetext}"
    search = SearchOperators.new query
    search.freetext do |freetext|
      expect(freetext).to eq freetext
    end
  end
end
