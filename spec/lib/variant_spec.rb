require "spec_helper"
require "variant"
require "item"

describe Variant do
  let(:html) { File.open('spec/html_fixture/detail_page.html') }
  let(:item) { Item.new }
  let(:variant) { Variant.new(item: item) }

  it "has item" do
    expect(variant.item).to eq(item)
  end

  describe ".parse" do
    let(:variants) { Variant.parse(html) }

    context "when discounted" do
      it "initialize variants" do
        expect(variants.count).to eq 2
      end

      it "sets attributes fo variants" do
        expect(variants.map(&:size)).to eq ["8+Year", "10+Year"]
        expect(variants.map(&:proper_price)).to eq ["34.10", "34.10"]
        expect(variants.map(&:reduced_price)).to eq ["17.05", "17.05"]
      end
    end

    context "when no discounted" do
      let(:html) { File.open('spec/html_fixture/detail_page_no_discount.html') }
      it "sets attributes fo variants" do
        expect(variants.map(&:size)).to eq ["3+Year", "4+Year", "5+Year", "6+Year"]
        expect(variants.map(&:proper_price)).to eq ["30.60", "30.60", "30.60", "33.65"]
        expect(variants.map(&:reduced_price)).to eq ["30.60", "30.60", "30.60", "33.65"]
      end
    end
  end
end
