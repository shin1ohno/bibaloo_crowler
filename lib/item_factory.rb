require "open-uri"
require_relative "./item"
require_relative "./variant"

class ItemFactory
  def initialize(html)
    @html = html
    @nodes = Nokogiri::HTML.parse(html, nil, nil).xpath("//ul[@class='browse-products']/div[@class='item-small']")
  end

  def new_items
    @nodes.map do |node|
      Item.new(html: node.to_html)
    end
  end
end
