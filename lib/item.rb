require "nokogiri"

class Item
  attr_reader :html, :dom, :name, :brand_name, :variants

  def initialize(html: nil)
    @html = html
    @charset = nil
    @variants = []
  end

  def parse!
    set_attributes!(Nokogiri::HTML.parse(@html, nil, @charset))
  end

  private

  def set_attributes!(nodes)
    @brand_name = nodes.xpath("//a[@class='item-name']")[0].text
    @name = nodes.xpath("//a[@class='item-name']")[1].text

    nodes.xpath("//td[@class='size-content']/ul/li").each do |node|
      @variants << node.text
    end
  end
end
