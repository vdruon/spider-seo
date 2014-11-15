require "spider-seo/version"
require 'nokogiri'
require 'spider-seo/metadata'

module SpiderSeo
  class Document
    # Contains Nokogiri::HTML::Document object
    attr_accessor :document
    attr_accessor :metadata

    # Initializer
    # uri_or_html is either an URI or a HTML string
    # options is options to pass to open-uri#open
    def initialize uri_or_html = nil, options = {}
      if uri_or_html
        require 'uri'
        if uri_or_html =~ /\A#{URI::regexp}\z/ # Use URI::regexp to check if uri_or_html is an uri
          self.document = from_uri uri_or_html
        elsif uri_or_html =~ /^s*<[^Hh>]*html/ # Use regexp to check if uri_or_html is a HTML string
          self.document = from_html uri_or_html, options
        else
          raise "The string you provided is neither an URI nor a HTML string."
        end
        self.metadata = SpiderSeo::Document::Metadata.new(self.document)
      end
      return self
    end

    # Returns a Nokogiri::HTML::Document
    # From a HTML string
    def from_html html
      self.document = Nokogiri::HTML(html)
    end

    # Returns a Nokogiri::HTML::Document
    # From an uri
    # options are options available for open_uri#open
    def from_uri uri, options = {}
      require 'open-uri'
      self.document = Nokogiri::HTML(open(uri, options))
    end
  end
end
