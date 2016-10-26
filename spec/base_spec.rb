

require 'search_operators'
RSpec.describe "freetext" do
  it "only free text" do
    query = "I only contain free text"
    search = SearchOperators.new query
    search.freetext do |freetext|
      expect(freetext).to eq query
    end
  end
end
