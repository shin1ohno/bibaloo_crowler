require 'nokogiri'

class Variant
  attr_accessor :item, :size, :proper_price, :reduced_price

  def initialize(item: nil)
    @item = item
  end

  def to_s
    "#{@item.name} of #{@item.brand_name} for #{@size} at £#{@reduced_price}"
  end

  def self.parse(html)
    nodes = (Nokogiri::HTML.parse(html, nil, nil))
    variants = []
    nodes.xpath('//option').each do |node|
      next if node.attr("value") == ""
      variant = Variant.new
      variant.size = node.attr("value")
      price = node.xpath('div').text.gsub(/\u00A3/, "")
      if price == ""
        proper_price = node.text.gsub(/.*\(\u00A3/, "").gsub(/\).*/, "")
        variant.proper_price = proper_price
        variant.reduced_price = proper_price
      else
        variant.proper_price = price
        variant.reduced_price = node.text.gsub(/.*NOW: \u00A3/, "").gsub(/\).*/, "")
      end
      variants << variant
    end
    variants
  end
end
