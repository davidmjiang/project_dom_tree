def parse_tag(string)
  tag_hash = {}
  tag_hash[:type] = string.match(/<(.*?)\s/)[1]
  tag_hash[:id] = string.match(/id='(.*?)'/)[1]
  tag_hash[:name] = string.match(/name='(.*?)'/)[1]
  tag_hash[:class] = string.match(/class='(.*?)'/)[1].split(" ")
  tag_hash
end

# "<p class='foo bar' id='baz' name='fozzie'>"

# tag.type /<.*?\s/
# => "p"
# tag.classes /class='(.*?)'/
# => ["foo", "bar"]
# tag.id /id='(.*?)'/
# => "baz"
# tag.name /name='(.*?)'/
# => "fozzie"

parse_tag("<p class='foo bar' id='baz' name='fozzie'>")

#Node = Struct.new(:tag, :data, :children)
Node = Struct.new(:tag, :children, :parent)

class HTMLParser

attr_reader :root

  OPENING = /<([a-z]*?)>/
  CLOSING = /<\/([a-z]*?)>/
  BOTH = /<.*?>/

  def initialize(html)
    @root = Node.new("document", {:type => "document"},[], nil) 
    @html = html
    @stack = []
  end

  def tags
    @html.scan(BOTH)
  end

  def text
    @html.split(BOTH)
  end

  def parse
    tags_array = tags
    text_array = text[1..-1]
    current_parent = @root
    current_node = Node.new(tags_array.shift,[], @root)
    current_parent.children << current_node
    current_node.children << text_array.shift
    until tags_array.empty?
      if tags_array[0].match(/\/#{current_node.tag[1..-2]}/)
        current_node = current_node.parent
        tags_array.shift
        current_node.children << text_array.shift
      else
        current_parent = current_node
        current_node = Node.new(tags_array.shift,[],current_parent)
        current_parent.children << current_node
        current_node.children << text_array.shift
      end
    end
  end

end

def outputter(node)
  current_root = node
  puts current_root.tag
  current_root.children.each do |child|
    if child.is_a?(String)
      puts child
    else
      outputter(child)
    end
  end
  puts "</#{current_root.tag[1..-2]}>"
end

h = HTMLParser.new("<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>")

