module SpiderSeo
  class Document
    class Tag
      attr_accessor :name
      attr_accessor :text
      attr_accessor :attributes
      attr_accessor :children

      # Constructor
      def initialize name = nil, text = nil, attributes = [], children = []
        self.name = name
        self.text = text
        self.attributes = attributes
        self.children = children
      end

      def to_s
        "#{self.name}
          \n\tText : #{self.text}
          \n\tAttributes : #{attributes.map{|a| a.to_s}}"
      end
    end
  end
end