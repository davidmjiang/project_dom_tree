module DOMParser

Node = Struct.new(:tag, :attributes, :children, :parent) do

  def matches_attribute?(attribute, value)
    return false unless attributes[attribute]
    if attribute == :class
      attributes[:class].include?(value)
    else
      attributes[attribute]==value
    end
  end

  def attributes_string
    str = ""
    attributes.each do |attribute, value|
      str << "#{attribute}: #{value} |"
    end
  end

  def to_s
    "Attributes: #{attributes_string}"
  end

end

end

#tag => what will actually be printed (everything between the < and >)
#attributes => a hash of all its attributes, such as type, id, class ,etc.