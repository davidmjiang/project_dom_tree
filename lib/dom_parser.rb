require_relative 'node_renderer'

include DOMParser

#test_code

puts "Welcome to the DOM Parser. Please enter your file name:"
file_name = gets.chomp
file_string = File.read(file_name)
parser = HTMLParser.new(file_string)
parser.parse

searcher = TreeSearcher.new(parser.root)
renderer = NodeRenderer.new(parser.root)

loop do 
puts "Would you like to Search (s) or Render (r)?"
puts "q to quit"
s_or_r = gets.chomp
break if s_or_r == "q"
case s_or_r
  when "r"
    parser.outputter(parser.root)
  when "s"
    puts "What would you like to search for? Type (t), class (c), id (i) or name (n)?"
    search_1 = gets.chomp
    case search_1
      when "t"
        attribute = :type
      when "c"
        attribute = :class
      when "i"
        attribute = :id
      when "n"
        attribute = :name
    end
    puts "What value would you like to search for?"
    search_2 = gets.chomp
    results = searcher.search_by(attribute,search_2)
    renderer.render_results(results)
end
end

