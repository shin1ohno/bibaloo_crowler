require "open-uri"
require_relative "./item"
require_relative "./variant"

class VariantFactory
  def initialize(item)
    item.parse!
    @item = item
  end

  def new_variants
    html = ""
    open(@item.detail_url){|f| html << f.read }
    Variant.parse(html).each{ |variant| variant.item = @item }
  end
end
