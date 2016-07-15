def parse_tag(string)
  tag_hash = {}
  tag_hash[:type] = string.match(/<(.*?)\s/)[1]
  tag_hash[:id] = string.match(/id='(.*?)'/)[1]
  tag_hash[:name] = string.match(/name='(.*?)'/)[1]
  tag_hash[:class] = string.match(/class='(.*?)'/)[1].split(" ")
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

Node = Struct.new(:tag, :data, :children)

class HTMLParser

  OPENING = /<([a-z]*?)>/
  CLOSING = /<\/([a-z]*?)>/
  BOTH = /<(.*?)>/

  def initialize(html)
    @root = Node.new("html",html, []) 
    @stack = []
    parser(@root)
    @html = html
  end

  def tags
    @html.scan(/<.*?>/)
  end

  def text
    @html.split(/<.*?>/)
  end

  def parser(node)

  end

# "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"

#find the first tag in the string
#make a new node with tag = parse_tag(that tag) and data = the rest. this is the root.
#repeat with the rest of the tags inside the root's data, setting their parent to the root

# <div>
#   div text before
#   <p>
#     p text
#   </p>
#   <div>
#     more div text
#   </div>
#   div text after
# </div>




    # first_match = node.data.match(/<([a-z]*?)>/)
    # stack = []
    # if first_match
    #   first_tag = first_match[1]
    #   rest_of_string = first_match.post_match
    #   new_node = Node.new(first_tag, rest_of_string, [])
    #   stack << new_node
    #   node.children << new_node
    # end
    # binding.pry
    # stack.pop if new_node.data.match(/<\/([a-z]*?)>/)[1] == stack[-1].tag
    # until stack.empty?
    #   parser(new_node)
    # end







end

h = HTMLParser.new("<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>")


puts h.tags

