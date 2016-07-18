require_relative '../lib/node_renderer'

describe TreeSearcher do

  let(:html){File.read("../lib/test.html")}
  let(:parser){HTMLParser.new(html)}

  before do
    parser.parse
  end

  let(:searcher){TreeSearcher.new(parser.root)}

  describe "#search_by" do

    it "returns an empty array if no elements are found" do
      expect(searcher.search_by(:type,"h3")).to eq([])
    end

    it "finds matches of a class" do
      expect(searcher.search_by(:class, "funky").length).to eq(1)
    end

    it "finds all matches of a type" do
      expect(searcher.search_by(:type, "li").length).to eq(13)
    end
  end
end