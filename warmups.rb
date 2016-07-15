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

  def initialize(html)
    @root = Node.new("html",html, []) 
    parser(@root)
  end

  def parser(node)
    first_match = node.data.match(/<(.*?)>/)

    (/<\/(.*?)>/)

    first_tag = first_match[1]
    rest_of_string = first_match.post_match
    node.children << Node.new(parse_tag(first_tag), rest_of_string, nil) 

    next_match = root.rest_of_string.match(/<(.*?)\s/)
    next_tag = next_match[1]
    rest_of_it = next_tag.post_match
    next_node = Node.new(parse_tag(next_tag), rest_of_it, root) # p
  end

/<(.*?)>/

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







end

