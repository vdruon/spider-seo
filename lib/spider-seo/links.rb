require 'spider-seo/links/link'
require 'spider-seo/utils'

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
          node.name,
          node['href'],
          node.text,
          SpiderSeo::Utils::attributes(node)
        )}
      end

      # Get all document's <a> tags with attribute rel="nofollow"
      def no_follow
        all.select {|link| link.is_no_follow? }
      end

      # Get all document's <a> tags that have not attribute rel="nofollow"
      def followed
        all.select {|link| not link.is_no_follow? }
      end
    end
  end
end