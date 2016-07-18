require 'html_parser'

describe HTMLParser do

  let(:html) {"<div>  div text before  <p class=a_class>    p text  </p>  <div>    more div text  </div>  div text after</div>"}

  let(:parser) {HTMLParser.new(html)}

  describe '#initialize' do

    it 'sets root to document' do
      expect(parser.root.tag).to eq("document")
    end

  end

  describe '#parse' do

    before do
      parser.parse()
    end

    it "can handle simple tags" do
      expect(parser.root.children[0].tag).to eq("<div>")
    end

    it "can handle tags with attributes" do
      expect(parser.root.children[0].children[1].tag).to eq("<p class=a_class>")
    end

    it "can handle simple nested tags" do
      expect(parser.root.children[0].children[3].tag).to eq("<div>")
    end

    it "can handle text both before and after a nested tag" do
      expect(parser.root.children[0].children[0]). to eq("  div text before  ")
    end
  end

end