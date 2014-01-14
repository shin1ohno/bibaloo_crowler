require_relative '../lib/item_factory'
require_relative '../lib/variant_factory'

contents = if ARGV[0].match(/^http/)
  require "open-uri"
  html = ""
  open(ARGV[0]){|f| html << f.read }
  html
else
  File.open(ARGV[0])
end

item_factory = ItemFactory.new(contents)
items = item_factory.new_items
items_count = items.count
variants = []

items.each_with_index do |item, i|
  variants = VariantFactory.new(item).new_variants
  variants.concat(variants)
  puts "processed #{item} (#{i+1}/#{items_count}):"
  puts item.detail_url
  variants.each do |v|
    puts v
  end
  puts ""
end

