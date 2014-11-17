require 'spider-seo/links/link'
require 'spider-seo/attribute'

module SpiderSeo
  class Document
    class Links

      # Initializer
      # param document is a Nokogiri::HTML::Document object
      def initialize doc
        self.document = doc
      end

      attr_accessor :document

      # Get all document's <a> tags
      def all
        links = self.document.css('a')
        links.map {|node| SpiderSeo::Document::Links::Link.new(
          node['href'],
          node.text,
          node.attribute_nodes.map { |att| SpiderSeo::Document::Attribute.new(att.node_name, att.value) }
          )}
      end
    end
  end
end