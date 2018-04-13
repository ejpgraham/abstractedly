module Feedjira
  module Parser
    # Parser for dealing with Atypon feeds.
    class Atypon
      include SAXMachine
      include Feedjira::FeedUtilities
      element :"rss:title", as: :poop
      element :"rss:description", as: :description
      element :"rss:link", as: :url
      elements :"rss:item", as: :entries, class: AtyponEntry

      attr_accessor :feed_url

      def self.able_to_parse?(xml) #:nodoc:
        (/\<rdf\:RDF/ =~ xml) && (/\<rss\:channel/ =~ xml)
      end
    end
  end
end


module Feedjira
  module Parser
    # Parser for dealing with Atypon RSS feed entries.
    # URL: https://www.atypon.com/
    class AtyponEntry
      include SAXMachine
      include FeedEntryUtilities

      element :"rss:title", as: :title
      element :"rss:link", as: :url
      element :"dc:description", as: :paragraph

      element :"dc:creator", as: :author
      element :"rss:author", as: :author
      element :"content:encoded", as: :content
      element :"rss:description", as: :summary

      element :"media:content", as: :image, value: :url
      element :"rss:enclosure", as: :image, value: :url

      element :"rss:pubDate", as: :published
      element :"rss:pubdate", as: :published
      element :"dc:date", as: :published
      element :"dc:Date", as: :published
      element :"dcterms:created", as: :published

      element :"dcterms:modified", as: :updated
      element :"rss:issued", as: :published
      elements :"rss:category", as: :categories

      element :"rss:guid", as: :entry_id
      element :"dc:identifier", as: :entry_id
    end
  end
end
