require_relative 'node'

class HTMLParser

  attr_reader :root

  OPENING = /<(([a-z][1-9]?)*?)>/
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

  def parse_tag(string)
    tag_hash = {}
    #if no spaces, then store what is between the <> in type
    if !string.match(/\s/)
      tag_hash[:type] = string.match(OPENING)[1]
    else
      tag_hash[:type] = string.match(/<(.*?)\s/)[1]
    end
    tag_hash[:id] = string.match(/id="(.*?)"/)[1] if string.match(/id="(.*?)"/)
    tag_hash[:name] = string.match(/name="(.*?)"/)[1] if string.match(/name="(.*?)"/)
    tag_hash[:class] = string.match(/class="(.*?)"/)[1].split(" ") if string.match(/class="(.*?)"/)
    tag_hash
  end

  def parse
    tags_array = tags
    text_array = text[1..-1]
    current_parent = @root
    current_tag = tags_array.shift
    current_node = Node.new(current_tag, parse_tag(current_tag),[], @root)
    current_parent.children << current_node
    current_node.children << text_array.shift
    until tags_array.empty?
      if tags_array[0].match(/\/#{current_node.attributes[:type]}/)
        current_node = current_node.parent
        tags_array.shift
        current_node.children << text_array.shift
      else
        current_parent = current_node
        current_tag = tags_array.shift
        #binding.pry
        current_node = Node.new(current_tag, parse_tag(current_tag),[],current_parent)
        current_parent.children << current_node
        current_node.children << text_array.shift
      end
    end
  end

  def find_node(node)

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

end